class SearchController < ApplicationController

  def index
    @search = search_term
    @results = PgSearch.multisearch(@search)
  end

  def post
    redirect
  end

  private

  def search_term
    params[:search]
  end

end