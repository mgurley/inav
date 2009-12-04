class PatientView < ActiveRecord::Base
  set_table_name "patients_view"

  named_scope :by_first_name_last_name_medical_record_number, lambda { |search|
    {:conditions => ["LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ? OR medical_record_number LIKE ? OR LOWER(first_name)||' '||LOWER(last_name) LIKE ?", "%#{search.to_s.downcase}%","%#{search.to_s.downcase}%","%#{search}%","%#{search.to_s.downcase}%"]}
  }

  cattr_reader :per_page
  @@per_page = 10

  
  def self.search(page, sort, search)
    
    sort = case sort
           when "first_name"  then "first_name"
           when "first_name_reverse"  then "first_name DESC"
           when "last_name"  then "last_name"
           when "last_name_reverse"  then "last_name DESC"
           when "gender"  then "gender_types_name"
           when "gender_reverse"  then "gender_types_name DESC"
           when "date_of_birth"  then "date_of_birth"
           when "date_of_birth_reverse"  then "date_of_birth DESC"
           when "medical_record_number"  then "medical_record_number"
           when "medical_record_number_reverse"  then "medical_record_number DESC"

           else "last_name"
           end
    
    if search
      PatientView.by_first_name_last_name_medical_record_number(search).paginate :page => page, :order => sort
    else
      PatientView.paginate :page => page, :order => sort
    end  
    
  end
  
end
