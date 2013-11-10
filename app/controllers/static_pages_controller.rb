class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @event = current_user.events.build if signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end
end
