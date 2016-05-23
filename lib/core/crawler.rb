require "open-uri"
require "nokogiri"

class Core::Crawler
  attr_reader :uri

  MAX_SLEEP_TIME = 2.0
  TIMESTAMP_FORMAT = "%Y%m%d%H%M%S"

  def initialize(uri)
    @uri = uri
  end

  def parse
    Nokogiri::HTML(open(uri))
  rescue OpenURI::HTTPError => e
    response = e.io
    p response.status
  rescue => e
    p e.message
  end

  def links(css_str = nil)
    return parse.xpath("//a").map { |e| e["href"] } unless css_str

    parse.css(css_str).map { |e| e.attributes["href"].value }
  end

  def sleep_random
    sleep (Random.new.rand(MAX_SLEEP_TIME))
  end

  def timestamp
    Time.now.strftime(TIMESTAMP_FORMAT)
  end
end
