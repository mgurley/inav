module PatientStudyCalendar
  require 'rest-open-uri-hack'
  require 'rexml/document'
  require 'cgi'

  module Resources

    class Resource
      attr_accessor :metadata

      def store_metadata(new_metadata)
        @metadata = {}
        new_metadata.each do |h,v|
          @metadata[h]=v
        end
      end

      def self.find(scope, options={})
        case scope
          when :all   then find_all(options)
          else             find_from_id(scope, options)
        end
      end

      def self.get(path, options)
        args = authorization_header(options[:proxy_ticket])
        response = open("#{PSC_CONFIG['psc_rest_url']}#{path}",args)
        xml = response.read
      rescue OpenURI::HTTPError => e
        status = e.io.status[0]
        RAILS_DEFAULT_LOGGER.error("Failed to get URI #{PSC_CONFIG['psc_rest_url']}#{path}.  Error message: #{e.message}. Error status: #{status}")
        raise e
      end

      def post(path, representation, options)
        args = {:method => :post}
        args["Content-Type"] = "text/xml"
        args["Content-Length"] = representation.size.to_s
        args[:body] = representation.to_s
        args.merge!(Resource.authorization_header(options[:proxy_ticket]))

        response = open("#{PSC_CONFIG['psc_rest_url']}#{path}",args)

        store_metadata(response.meta)

        response
      rescue OpenURI::HTTPError => e
        status = e.io.status[0]
        RAILS_DEFAULT_LOGGER.error("Failed to post to URI #{PSC_CONFIG['psc_rest_url']}#{path}.  Error message: #{e.message}. Error status: #{status}")
        raise e
      end

      def self.authorization_header(proxy_ticket)
        {"Authorization" => "psc_token #{proxy_ticket.ticket}"}
      end

      def self.request_proxy_ticket(proxy_granting_ticket)
        proxy_ticket = CASClient::Frameworks::Rails::Filter.client.request_proxy_ticket(proxy_granting_ticket, PSC_CONFIG['psc_service_uri'])
      rescue Exception => e
        RAILS_DEFAULT_LOGGER.error("Failed to request Proxy Ticket with with Proxy Granting Ticket  #{proxy_granting_ticket.ticket} for service uri #{PSC_CONFIG['psc_service_uri']}.  Error message: #{e.message}.")
        raise e
      end

      def self.convert_to_date(str)
        date_array = str.split("-")
        return Date.new(date_array[0].to_i, date_array[1].to_i,date_array[2].to_i)
      end
    end

    class Site < Resource
      attr_accessor :site_name, :assigned_identifier

      def initialize(site_name, assigned_identifier)
        @site_name = site_name
        @assigned_identifier = assigned_identifier
      end

      def self.find_all
        sites = []
        document = document = REXML::Document.new(self.get('sites'))
        REXML::XPath.each(document, "/sites/site") do |e|
          sites << Site.new(e.attributes['site-name'], e.attributes['assigned-identifier'])
        end
        sites
      end

      def self.find_from_id
      end
    end

    class Study < Resource
      attr_accessor :assigned_identifier, :planned_calendar

      def initialize(assigned_identifier, planned_calendar)
        @assigned_identifier  = assigned_identifier
        @planned_calendar     = planned_calendar
      end

      def self.find_all(options)
        studies = []
        document = REXML::Document.new(self.get('studies', options))

        # Degugging Code
        # file = File.open("studies.xml","w")
        # document.write(file, -1, false)

        REXML::XPath.each(document, "/studies/study") do |e|
          studies << Study.new(e.attributes['assigned-identifier'], e.attributes['last-modified-date'])
        end
        studies
      rescue Exception => e
        RAILS_DEFAULT_LOGGER.error "Caught an error trying to find all Studies. " + "Error message: #{e.message}."
        raise e
      end

      def self.find_from_id(id, options)
        document = REXML::Document.new(self.get("studies/#{CGI.escape(id.to_s)}/template/current",options))

        # file = File.open("study-snapshot.xml","w")
        # document.write(file, -1, false)

        study_snapshot = REXML::XPath.first(document, "/study-snapshot")
        study = Study.new(study_snapshot.attributes['assigned-identifier'],nil)

        planned_calendar = REXML::XPath.first(document, "/study-snapshot/planned-calendar")
        study.planned_calendar = PlannedCalendar.new(planned_calendar.attributes['id'],nil)

        index = 0
        REXML::XPath.each(document, "/study-snapshot/planned-calendar/epoch") do |epoch|
          study.planned_calendar.epochs << Epoch.new(epoch.attributes['id'],epoch.attributes['name'],nil)

          REXML::XPath.each(document, "/study-snapshot/planned-calendar/epoch[@id='#{epoch.attributes['id']}']/study-segment") do |study_segment|
            study.planned_calendar.epochs[index].study_segments << StudySegment.new(study_segment.attributes['id'],study_segment.attributes['name'])
          end
          index = index + 1
        end
        study
      rescue Exception => e
        RAILS_DEFAULT_LOGGER.error "Caught an error trying to find Study by id. " + "Error message: #{e.message}."
        raise e
      end

      def epoch_study_segments
        epoch_study_segments =[]
        unless self.planned_calendar.nil?
          self.planned_calendar.epochs.each do |epoch|
              epoch.study_segments.each do |study_segment|
                epoch_study_segments << {:name => epoch.name + ' | ' + study_segment.name, :id => study_segment.id }
              end
          end
        end
        epoch_study_segments
      end
    end

    class PlannedCalendar < Resource
      attr_accessor :id, :epochs

      def initialize(id, epochs)
        @id     = id
        @epochs = epochs || []
      end
    end

    class Epoch < Resource
       attr_accessor :id, :name, :study_segments

       def initialize(id, name, study_segments)
         @id              = id
         @name            = name
         @study_segments  = study_segments || []
       end
    end

    class StudySegment < Resource
      attr_accessor :id, :name

       def initialize(id, name)
         @id              = id
         @name            = name
       end

    end

    class Registration < Resource
      attr_accessor :site_assigned_identifier, :study_assigned_identifier, :first_study_segment_id, :date, :subject_coordinator_name, :desired_assignment_id, :subject

       def initialize(site_assigned_identifier, study_assigned_identifier, first_study_segment_id, date, subject_coordinator_name, desired_assignment_id, subject)
         @site_assigned_identifier  = site_assigned_identifier
         @study_assigned_identifier = study_assigned_identifier
         @first_study_segment_id    = first_study_segment_id
         @date                      = date
         @subject_coordinator_name  = subject_coordinator_name
         @desired_assignment_id     = desired_assignment_id
         @subject                   = subject
       end

       def save!(options)
         post("studies/#{CGI.escape(self.study_assigned_identifier.to_s)}/sites/#{CGI.escape(self.site_assigned_identifier.to_s)}/subject-assignments", to_xml, options)

         # Degugging Code
         # document = REXML::Document.new(to_xml)
         # file = File.open("registration-new.xml","w")
         # document.write(file, -1, false)
       end

       def to_xml
         xm = Builder::XmlMarkup.new
         xm.instruct!
         xm.registration("xmlns"=>"http://bioinformatics.northwestern.edu/ns/psc", "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance","xsi:schemaLocation" => "http://bioinformatics.northwestern.edu/ns/psc http://bioinformatics.northwestern.edu/ns/psc/psc.xsd", "first-study-segment-id" => self.first_study_segment_id, "date"=>self.date.to_s,"subject-coordinator-name"=> self.subject_coordinator_name, "desired-assignment-id" =>self.desired_assignment_id.to_s){
              xm.subject( "first-name"=>self.subject.first_name,"last-name"=>self.subject.last_name, "birth-date"=> self.subject.birth_date.to_s, "person-id" => self.subject.person_id.to_s, "gender"=> self.subject.gender)
            }
         xm.target!
       end
    end

    class Subject < Resource
      attr_accessor :first_name, :last_name, :birth_date, :person_id, :gender

      def initialize(first_name, last_name, birth_date, person_id, gender)
        @first_name   = first_name
        @last_name    = last_name
        @birth_date   = birth_date
        @person_id    = person_id
        @gender       = gender
      end
    end

    class ScheduledCalendar < Resource
      attr_accessor :id, :assignment_id, :scheduled_study_segment

      def initialize(id, assignment_id, scheduled_study_segment)
        @id                       = id
        @assignment_id            = assignment_id
        @scheduled_study_segment  = scheduled_study_segment
      end

      def self.find(study_identifier, assignment_identifier, options)
        document = REXML::Document.new(self.get("studies/#{CGI.escape(study_identifier.to_s)}/schedules/#{CGI.escape(assignment_identifier.to_s)}",options))

        # file = File.open("scheduled-calendar.xml","w")
        # document.write(file, -1, false)

        scheduled_calendar_document = REXML::XPath.first(document, "/scheduled-calendar")
        scheduled_calendar = ScheduledCalendar.new(scheduled_calendar_document.attributes['id'], scheduled_calendar_document.attributes['assignment-id'], nil)

        scheduled_study_segment = REXML::XPath.first(document, "/scheduled-calendar/scheduled-study-segment")

        scheduled_calendar.scheduled_study_segment = ScheduledStudySegment.new(scheduled_study_segment.attributes['id'],scheduled_study_segment.attributes['start-date'], scheduled_study_segment.attributes['study-segment-id'], scheduled_study_segment.attributes['start-day'], nil)

        index = 0
        REXML::XPath.each(document, "/scheduled-calendar/scheduled-study-segment/scheduled-activity") do |scheduled_activity|
          scheduled_calendar.scheduled_study_segment.scheduled_activities << ScheduledActivity.new(scheduled_activity.attributes['id'], scheduled_activity.attributes['ideal-date'], scheduled_activity.attributes['repetition-number'], scheduled_activity.attributes['planned-activity-id'], nil)

          REXML::XPath.each(document, "/scheduled-calendar/scheduled-study-segment/scheduled-activity[@id='#{scheduled_activity.attributes['id']}']/current-scheduled-activity-state") do |current_scheduled_activity_state|
            scheduled_calendar.scheduled_study_segment.scheduled_activities[index].current_scheduled_activity_state = CurrentScheduledActivityState.new(current_scheduled_activity_state.attributes['date'], current_scheduled_activity_state.attributes['state'])
          end
          index = index + 1
        end
        scheduled_calendar
      rescue Exception => e
        RAILS_DEFAULT_LOGGER.error "Caught an error trying to find ScheduledCalendar by id. " + "Error message: #{e.message}."
        raise e
      end

      def active?
        scheduled_study_segment.scheduled_activities.any?{|scheduled_activity| scheduled_activity.current_scheduled_activity_state.state == 'scheduled' || scheduled_activity.current_scheduled_activity_state.state == "conditional"}
      end

      def last_occurred_activity
       scheduled_activity = occurred_activites.max{|a,b| a.current_scheduled_activity_state.date <=> b.current_scheduled_activity_state.date}
       scheduled_activity.nil? ? ""  : scheduled_activity.current_scheduled_activity_state.date
      end

      def occurred_activites
        occurred_activites = scheduled_study_segment.scheduled_activities.collect{|scheduled_activity| scheduled_activity if scheduled_activity.current_scheduled_activity_state.state == 'occurred'}
        occurred_activites.compact!
        occurred_activites ||=[]
      end

      def due_activites
        due_activites = scheduled_study_segment.scheduled_activities.collect{|scheduled_activity| scheduled_activity if (scheduled_activity.current_scheduled_activity_state.state == 'scheduled' or scheduled_activity.current_scheduled_activity_state.state == 'conditional')}
        due_activites.compact!
        due_activites ||=[]
      end

      def overdue_activites
        overdue_activites = due_activites.collect{|due_activity| due_activity if (Resource.convert_to_date(due_activity.current_scheduled_activity_state.date) < Date.today)}
        overdue_activites.compact!
        overdue_activites ||=[]
      end

      def status
        status = active? ?  "Due" : "Complete"
        status = "Overdue" if overdue_activites.size > 0
        status
      end
    end

    class ScheduledStudySegment < Resource
      attr_accessor :id, :start_date, :study_segment_id, :start_day, :scheduled_activities

      def initialize(id, start_date, study_segment_id, start_day, scheduled_activities)
        @id                       = id
        @start_date               = start_date
        @study_segment_id         = study_segment_id
        @start_day                = start_day
        @scheduled_activities     = scheduled_activities || []
      end
    end

    class ScheduledActivity < Resource
      attr_accessor :id, :ideal_date, :repetition_number, :planned_activity_id, :current_scheduled_activity_state

      def initialize(id, ideal_date, repetition_number, planned_activity_id, current_scheduled_activity_state)
        @id                               = id
        @ideal_date                       = ideal_date
        @repetition_number                = repetition_number
        @planned_activity_id              = planned_activity_id
        @current_scheduled_activity_state = current_scheduled_activity_state
      end
    end

    class CurrentScheduledActivityState < Resource
      attr_accessor :date, :state

      def initialize(date, state)
        @date     = date
        @state    = state
      end
    end
  end
end