# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
require_relative 'env'
# Initialize the Rails application.
ENV['DATABASE_PASSWORD'] = DATABASE_PASSWORD
ENV['DATABASE_USERNAME'] = DATABASE_USERNAME
Rails.application.initialize!
