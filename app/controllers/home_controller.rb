class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def autocomplete_keyword_word
    word = Pinyin.t(params[:term], '')
    @words = Keyword.where({:pinyin => /#{word}/i}).limit(10).order_by("id desc")
    respond_to do |format|
      format.json { render :json => json_for_autocomplete(@words) }
    end
  end
end
