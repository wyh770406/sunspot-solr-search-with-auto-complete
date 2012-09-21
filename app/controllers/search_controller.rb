# coding: utf-8
class SearchController < ApplicationController
  def index

    search_text = params[:q]
    @search_key = search_text
    @search = Sunspot.search(Product) do
      keywords search_text, :highlight => true
      paginate :page => params[:page], :per_page => 20
      order_by :created_at, :desc
    end


  end


end
