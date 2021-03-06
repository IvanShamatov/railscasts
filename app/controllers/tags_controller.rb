class TagsController < ApplicationController
  def show
    @tag = Tag.find(params[:id].to_i)
    @episodes = @tag.episodes.published.recent.paginate(:page => params[:page], :per_page => 10, :count => { :select => "*" })
  end
end
