class PagesController < ApplicationController
  skip_before_action :require_login

  def privacy
  end

  def terms
  end

  def contact
  end
end
