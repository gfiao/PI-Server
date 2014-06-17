class Content < ActiveRecord::Base

  # has_many :content_videos
  # has_many :videos, through: :content_videos
  has_one :video

  has_many :tag_contents
  has_many :tags, through: :tag_contents

  has_many :bookmarked_contents
  has_many :users, through: :bookmarked_contents

  has_many :users

  accepts_nested_attributes_for :tags
  validates :title, presence: true

  def print
    puts "===================== LALALALALA ================="
  end

  def feeds
    # PARSE DE UM RSS FEED.APENAS PARA EFEITO DE TESTE, REMOVER MAIS TARDE!

    require 'rss'
    rss = RSS::Parser.parse('http://feeds.feedburner.com/PublicoRSS?format=xml', false)
    puts "============================ INICIO FEEDS ==========================="
    rss.items.each do |item|
      puts "#{item.pubDate} - #{item.title}"
    end
    puts "============================ FIM FEEDS ==========================="

    render nothing: true
  end

end
