class GummiesController < ApplicationController
  def index
    @gummies = Gummy.all
  end
end
