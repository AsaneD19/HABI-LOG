class SearchesController < ApplicationController

  def index
    @results = @q.result(distinct: true).includes(:habits)
  end

end
