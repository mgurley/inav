require "calendar_date_select/calendar_date_select.rb"
require "calendar_date_select/form_helpers.rb"
require "calendar_date_select/includes_helper.rb"

ActionView::Helpers::FormHelper.send(:include, CalendarDateSelect::FormHelpers)
ActionView::Base.send(:include, CalendarDateSelect::FormHelpers)
ActionView::Base.send(:include, CalendarDateSelect::IncludesHelper)

# Filthy backwards compatibility hooks... grumble
if ([Rails::VERSION::MAJOR, Rails::VERSION::MINOR] <=> [2, 2]) == -1
  ActionView::Helpers::InstanceTag.class_eval do
    def self.new_with_backwards_compatibility(object_name, method_name, template_object, object = nil)
      new(object_name, method_name, template_object, nil, object)
    end
  end

else
  ActionView::Helpers::InstanceTag.class_eval do
    class << self; alias new_with_backwards_compatibility new; end
  end
end