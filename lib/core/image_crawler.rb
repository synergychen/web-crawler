class Core::ImageCrawler < Core::Crawler
  attr_reader :uri, :save_path

  def initialize(uri)
    super(uri)
  end

  def links
    img_doms = parse.xpath("//img/@src")
    img_doms.map { |img_dom| img_dom.value }
  end

  def save_links
    links.each_with_index do |img_uri, index|
      ImageTask.create(uri: img_uri)
    end
  end
end
