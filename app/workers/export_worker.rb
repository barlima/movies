class ExportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    file_path = "tmp/movies.csv"
    user = User.find_by(id: user_id)
    MovieExporter.new.call(user, file_path)
  end
end
