class TvController < ApplicationController

  http_basic_authenticate_with :name => "admin", :password => "badjoras"

  def show
    render :layout => false

  end
end
