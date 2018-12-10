class EmailWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id, movie_id)
    user = User.find_by(id: user_id)
    movie = Movie.find_by(id: movie_id)
    MovieInfoMailer.send_info(user, movie).deliver_now
  end
end
