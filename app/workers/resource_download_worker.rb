class ResourceDownloadWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(root_dir, uri)
    file_name = uri.split("/").last
    dir_name = uri.split("/")[-3..-2].join

    FileUtils.mkdir_p("#{root_dir}/#{dir_name}")

    open("#{root_dir}/#{dir_name}/#{file_name}", "wb") do |file|
      file << open(uri).read
    end
  end
end
