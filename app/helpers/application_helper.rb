module ApplicationHelper
  include Pagy::Frontend

  def full_title(page_title = "")
    base_title = "Felicia"
    if page_title.present?
      "#{page_title} | #{base_title}"
    else
        base_title
    end
  end

  def currently_at
    render partial: 'shared/top_nav'
    render partial: 'shared/nav'
  end

end
