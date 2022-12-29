module ApplicationHelper
  def active?(status)
    status ? 'success' : 'danger'
  end

  def swal_type(type)
    case type
    when 'success', 'notice' then 'success'
    when 'alert' then 'warning'
    when 'danger', 'error', 'denied' then 'error'
    when 'question' then 'question'
    else 'info'
    end
  end
end
