class HomepageController < ApplicationController
  before_filter :update_video

  def update_video

    #estamos a aceder a partir da TV, actualizar o indice caso seja diferente do actual
    if !(params[:currIndex].nil?)
      # puts "fobiywvbefkf jobcwf qfb qefqbef qefb fq fqfwfqfbqi fjqhfbq fuiuhjnd qw   djkmsd bn "
      @video_id_table = CurrentVideo.first
      if !(@video_id_table.index == params[:currIndex])
        @video_id_table.index = params[:currIndex]
        @video_id_table.save
        puts @video_id_table.index
      end
    else
      # puts "HUHUHUHUHUHUHAUHUHAUHAUHUAHAUHA"
    end
  end

  def index

  end
end