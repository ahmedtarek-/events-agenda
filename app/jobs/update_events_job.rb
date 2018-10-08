class UpdateEventsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts "wowowowo first job"
  end
end
