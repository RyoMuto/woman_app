require 'nokogiri'

class Scraping 
  # def initialize(link)
  #   @link = link
  # end

  #initializeで取得したリンクを表示
  def get_link
    p @link
  end

  #ローカルHTMLファイルから画像のURLを生成する
  def get_local
    file_path = Rails.root.join('app','scrapes','rank_media.html.erb')
    f = File.open(file_path)
    xml_doc = Nokogiri::XML(f)
    # f.close()
    xml_doc.xpath("//ul[@class='clearfix']/li/a/img").each do |xpath_node|
      str = xpath_node.get_attribute(:src)
      str.slice!(0) 
      image_url = ('https://rank1-media.com' + str)
      puts image_url
    end
  end


  #ローカルファイルからスクレイピングしたURLを保存する
  def get_image_url
    file_path = Rails.root.join('app','scrapes','rank_media.html.erb')
    f = File.open(file_path)
    xml_doc = Nokogiri::XML(f)
    # f.close()

    #xpathでxml_docから画像URLを取得
    xml_doc.xpath("//ul[@class='clearfix']/li/a/img").each do |xpath_node|
      str = xpath_node.get_attribute(:src)
      str.slice!(0) 
      image_url = ('https://rank1-media.com' + str)

      #取得した画像URLをwomanテーブルのレコードに保存する
      Woman.create!(image_url: image_url)
    end
  end


  #htmlファイルを開く
  def open
    File.open('rank_media.html.erb') do |file|
      file.each_line do |subject|
        puts subject
      end
    end
  end

end