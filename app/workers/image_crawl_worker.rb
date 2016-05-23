class ImageCrawlWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(uri)
    img_crawler = Core::ImageCrawler.new(uri)
    img_crawler.save_links
  end
end
