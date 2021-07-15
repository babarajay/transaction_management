module ApplicationHelper

  def print_error(obj, field)
    return '' if obj.blank? || obj.keys.blank? || field.blank? || !obj.keys.include?(field)
    "<span class=\"error\">#{obj[field].uniq.join('<br>')}</span>".html_safe
  end

  def has_error(obj, field)
    return '' if obj.blank? || obj.keys.blank? || field.blank? || !obj.keys.include?(field)
    'has-error'
  end

  def user_listing
    User.all.collect{ |u| ["#{u.first_name} #{u.last_name}", u.id] }
  end
end

