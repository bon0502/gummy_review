# frozen_string_literal: true

module ApplicationHelper
  def page_title(title = '')
    base_title = "GummyReview"
    title.empty? ? base_title : "#{title} | #{base_title}"
  end
end
