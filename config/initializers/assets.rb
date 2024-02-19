# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.paths << "lib/initfest/assets/images"
Rails.application.config.assets.paths << "lib/initfest/assets/javascripts"
Rails.application.config.assets.paths << "lib/initfest/assets/stylesheets"
Rails.application.config.assets.precompile << /\.(?:png|jpg|jpeg|gif)\z/

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w[management/application.css management/application.js]
