## rationale
#monkey patching error_message_on to allow use of span instead of div

## lib/patches/error_message_on.rb
module ActionView

  module Helpers

    module ActiveRecordHelper

      # Returns a string containing the error message attached to the +method+ on the +object+, if one exists.
      # This error message is wrapped in a DIV tag, which can be specialized to include both a +prepend_text+ and +append_text+
      # to properly introduce the error and a +css_class+ to style it accordingly. Examples (post has an error message
      # "can't be empty" on the title attribute):
      #
      #   <%= error_message_on "post", "title" %> =>
      #     <span class="formError">can't be empty</span>
      #
      #   <%= error_message_on "post", "title", "Title simply ", " (or it won't work)", "inputError" %> =>
      #     <span class="inputError">Title simply can't be empty (or it won't work)</span>
      def error_message_on_tag(object, method, prepend_text = "", append_text = "", css_class = "formError", tag = "span")
        if (obj = instance_variable_get("@#{object}")) && (errors = obj.errors.on(method))
          content_tag(tag, "#{prepend_text}#{errors.is_a?(Array) ? errors.first : errors}#{append_text}", :class => css_class)
        else 
          ''
        end
      end

    end # module ActiveRecordHelper

  end # module Helpers

end # module ActionView

##
# rSpec Hash additions.
#
# From 
#   * http://wincent.com/knowledge-base/Fixtures_considered_harmful%3F
#   * Neil Rahilly

class Hash

  ##
  # Filter keys out of a Hash.
  #
  #   { :a => 1, :b => 2, :c => 3 }.except(:a)
  #   => { :b => 2, :c => 3 }

  def except(*keys)
    self.reject { |k,v| keys.include?(k || k.to_sym) }
  end

  ##
  # Override some keys.
  #
  #   { :a => 1, :b => 2, :c => 3 }.with(:a => 4)
  #   => { :a => 4, :b => 2, :c => 3 }
  
  def with(overrides = {})
    self.merge overrides
  end

  ##
  # Returns a Hash with only the pairs identified by +keys+.
  #
  #   { :a => 1, :b => 2, :c => 3 }.only(:a)
  #   => { :a => 1 }
  
  def only(*keys)
    self.reject { |k,v| !keys.include?(k || k.to_sym) }
  end

end
