class HomepageController < ApplicationController
  # before_filter :update_video
  # before_action :update_video, only: [:index]
  # skip_before_action :update_video, only: :index
  # before_action :update_video, except: [:index]

  def sync

  end

  def index
    # @current_video_info = nil
    puts "LOLOLOLOLOLOLOL"
    puts params[:currIndex]

    #estamos a aceder atraves do site, actualizar a info
    if params[:currIndex] == nil
      @current_video_info = Video.where("id = ?", 1).first

      puts "filha da putice esta merda nao funciona!"
      @current_video_info = @current_video_info.link

      puts @current_video_info
      # render :partial => 'sync'

      #estamos na tv, vamos actualizar a variavel
    else
      @current_video_info = params[:currIndex]
      puts @current_video_info
    end

  end

end










# if params[:currIndex] == nil
#   #este é o caso em que a tv nao está a correr e nao deve passar nada
#   @current_video_info = "A TV NÃO ESTÁ LIGADA!!!"
# else

# @current_video_info = Video.where('id' => params[:currIndex])


#este é o caso em que a tv nao está a correr e nao deve passar nada
# if @current_video_info == nil
#   # @current_video_info = "A TV NÃO ESTÁ LIGADA!!!"
# else
#
# end
# puts @current_video_info

# end










# protected
# def update_video
#   @current_video_info = []
#   temp = []
#   puts "hahahahahahahhaha"
# end