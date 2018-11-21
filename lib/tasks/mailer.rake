namespace :mailer do

  desc "Send movie data by email"
  task send_movie_data: :environment do
    # args MOVIE_ID, USER_ID
    movie = Movie.find_by(id: ENV["MOVIE_ID"])
    user = User.find_by(id: ENV["USER_ID"])
    if movie && user 
      MovieInfoMailer.send_info(user, movie).deliver_now
    end
  end

end
