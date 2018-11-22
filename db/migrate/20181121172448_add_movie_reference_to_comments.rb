class AddMovieReferenceToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :movie, foreign_key: true
  end
end
