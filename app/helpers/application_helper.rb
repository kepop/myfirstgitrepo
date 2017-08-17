module ApplicationHelper
  def error_messages_for(object_with_errors)
    render(:partial =>'application/error_messages', 
           :locals => {:object => object_with_errors} )
  end

  def status_tag(boolean, options={})
    options[:true_text] ||= ''
    options[:false_text] ||= ''

    if boolean
      ## content_tag is a special method to generate html tag
      content_tag(:span, options[:true_text], :class => 'status true')
    else
      content_tag(:span, options[:false_text], :class => 'status false')
    end
  end

end
