  class PagesController < ApplicationController
    def show
      @user = current_user
      @devices_sold = @user.selling
      @devices_bought = @user.buying
      render template: "pages/#{params[:page]}", locals: {}
    end
  end  