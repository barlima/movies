require "rails_helper"
require "rake"

describe "rake exporter:export_movies_data", type: :task do

  before do
    Rails.application.load_tasks
  end

  it "run task with no errors" do
    expect { Rake::Task['exporter:export_movies_data'].invoke }.not_to raise_exception
  end
end