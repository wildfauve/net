class SearchesController < ApplicationController
  
  def index
  end
  
  def new
    @search = Search.new
  end
  
  def create
    search = Search.new
    search.subscribe self
    search.perform(params[:search])
  end
  
end