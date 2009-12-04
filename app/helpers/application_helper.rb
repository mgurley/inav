# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def title(controller_name)
    @title = "Inflection Navigator"
    @title +=  ": " + controller_name.humanize unless controller_name == "home"
    @title
  end

  def sort_td_class_helper(param)
    result = 'class="sortup"' if params[:sort] == param
    result = 'class="sortdown"' if params[:sort] == param + "_reverse"
    return result
  end

  def sort_link_helper(text, param)
    key = param
    key += "_reverse" if params[:sort] == param

    link_to(text, {:action => :index ,:params => params.merge({:sort => key, :page => nil})},:title => "Sort by this field")
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def stylesheet(*files)
    content_for(:head) { stylesheet_link_tag(*files) }
  end

  # This helper method is used to generate the javascript to execute on the client
  # It assumes that the function update_select_options is already in the open document
  #
  # Options
  # <tt>:text</tt> - The method to use on collection objects to get the text for the option
  # <tt>:value</tt> - The method to use on collection objects to get the value attribute for the option
  # <tt>:include_blank</tt> - Includes a blank option at the top of cascaded boxes
  # <tt>:clear</tt> - An array that contains the dom id's of select boxes to clear when target_dom_id changes
  def update_select_box( target_dom_id, collection, options={} )
    # Set the default options
    options[:text] ||= 'name'
    options[:value] ||= 'id'
    options[:include_blank] ||= true
    options[:clear] ||= []
    pre = options[:include_blank] ? [['','']] : []

    out = "update_select_options( $('" << target_dom_id.to_s << "'),"

    if collection[0].kind_of? ActiveRecord::Base
      out << "#{(pre + collection.collect{ |c| [c.send(options[:text]), c.send(options[:value])]}).to_json}" << ","
    end

    if collection[0].kind_of? Hash
      out << "#{(pre + collection.collect{ |c| [c[options[:text]], c[options[:value]]]}).to_json}" << ","
    end

    if collection.size == 0
      out << "#{(pre).to_json}" << ","
    end
    out << "#{options[:clear].to_json} )"
  end

  def menu_selected?(controller_name)
    controller?(controller_name) ? "selected" : ""
  end

  def controller?(controller_name)
    controller.controller_name.downcase == controller_name.downcase
  end


  def welcome?
    controller.controller_name.downcase == 'registrations' && controller.action_name =='index'
  end

  def patient_referrer_url
    session[:patient_referrer_url] ? session[:patient_referrer_url] : patients_url
  end

  def provider_referrer_url
    session[:provider_referrer_url] ? session[:provider_referrer_url] : providers_url
  end

  def checked?(params, value, default)
    if params.nil? and default
      true
    else
      params == value
    end
  end

  def format_date(date)
    date.nil? ? '' : date.to_s(:date)
  end
end
