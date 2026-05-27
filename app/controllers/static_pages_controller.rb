# frozen_string_literal: true

class StaticPagesController < ApplicationController
  skip_before_action :require_login, only: %i[top terms privacy]

  def terms;
  end

  def top;
  end

  def privacy;
  end
end
