require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Clarion
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "Sofia"
    # config.eager_load_paths << Rails.root.join("extras")

    config.i18n.available_locales = [:bg, :en]
    config.i18n.default_locale = :bg

    config.active_record.schema_format = :sql

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        request_specs: false

      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
