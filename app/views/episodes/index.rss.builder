title = "Railscasts"
author = "Ryan Bates & railscasts.ru"
description = "Каждую неделю Райн Бейтс  выкладывает новый эпизод Railscasts, обучая приемам и технике работы с Ruby on Rails. Эти скринкасты - короткие и сфокусированные на одной конкретной технике/технологии, так что вы можете быстро войти в курс дела и применить данную технологию в ваших проектах. Аудиторию проекта составляют разработчики Ruby on Rails среднего уровня, но и новички, и даже эксперты могут для себя вынести что-то полезное."
keywords = "rails, ruby on rails, видео-уроки, видеоуроки, скринкасты, railscast, railscasts, rails casts, tricks, tutorials, обучение, программирование"

 if params[:ipod]
   title += " (iPod & Apple TV)"
   description += " This version is for the iPod or Apple TV, a full resolution version is also available."
   keywords += ', ipod'
   image = "http://railscasts.com/images/ipod_railscasts_cover.jpg"
   format = 'm4v'
 else
   description += " Это полная версия."
   image = "http://railscasts.com/images/railscasts_cover.jpg"
   format = 'mov'
 end
xml.instruct! :xml, :version => "1.0"
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd",  "xmlns:media" => "http://search.yahoo.com/mrss/",:version => "2.0" do
  xml.channel do 
    xml.title title
    xml.link 'http://railscasts.ru'
    xml.description description
    xml.language 'ru'
    xml.pubDate @episodes.first.published_at.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.published_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, :href => image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, 'ivan@railscasts.ru'
    end
    xml.itunes :block, 'no'
    xml.itunes :category, :text => 'Technology' do
      xml.itunes :category, :text => 'Software How-To'
    end
    xml.itunes :category, :text => 'Education' do
      xml.itunes :category, :text => 'Training'
    end
    
    @episodes.each do  |episode|
      download = episode.downloads.find_by_format(format)
      if download
        xml.item do
          xml.title "Выпуск #{episode.position+199}: #{episode.name}"
          xml.description episode.description
          xml.pubDate episode.published_at.to_s(:rfc822)
          xml.enclosure :url => download.url, :length => download.bytes, :type => 'video/quicktime'
          xml.link episode_url(episode)
          xml.guid({:isPermaLink => "false"}, episode.permalink)
          xml.itunes :author, author
          xml.itunes :subtitle, truncate(episode.description, :length => 150)
          xml.itunes :summary, episode.description
          xml.itunes :explicit, 'no'
          xml.itunes :duration, episode.duration
        end
      end
    end
  end
end
