class CrawlWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(base_uri, parent_uri, css_selector)
    crawler = Core::Crawler.new(parent_uri)
    child_uris = crawler.links(css_selector)

    child_uris.each do |child_uri|
      uri = full_uri(base_uri, child_uri)
      ImageCrawlWorker.perform_async(uri)
    end
  end

  private

  def full_uri(base_uri, uri)
    "#{base_uri}#{uri}"
  end
end
