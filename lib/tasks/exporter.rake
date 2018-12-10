namespace :exporter do

  desc "Eexport movies data in csv format"
  task export_movies_data: :environment do
    # args USER_ID
    file_path = "tmp/movies.csv"
    user = User.find_by(id: ENV["USER_ID"])
    if user 
      MovieExporter.new.call(user, file_path)
    end
  end
end
