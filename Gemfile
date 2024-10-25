source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2.0"
# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
  gem "rubocop-rails-omakase", require: false
end
# Vite.js in Ruby, bringing joy to your JavaScript experience [https://github.com/ElMassimo/vite_ruby]
gem "vite_rails", "~> 3.0"

# Operations research tools for Ruby [https://github.com/ankane/or-tools-ruby]
gem "or-tools", "~> 0.12.0", git: "https://github.com/rofaccess/or-tools-ruby"

# Ruby ASCII Table Generator, simple and feature rich [https://github.com/tj/terminal-table]
gem "terminal-table", "~> 3.0"

# A library for bulk insertion of data into your database using ActiveRecord [https://github.com/zdennis/activerecord-import]
gem "activerecord-import", "~> 1.7"
