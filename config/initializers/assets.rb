# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff )
Rails.application.config.assets.precompile += %w( dashboard/home.js )
Rails.application.config.assets.precompile += %w( dashboard/home.css.scss )
Rails.application.config.assets.precompile += %w( dashboard/index.css.scss )
Rails.application.config.assets.precompile += %w( ads_performances/index.css.scss )
Rails.application.config.assets.precompile += %w( welcome/index.css.scss )
Rails.application.config.assets.precompile += %w( registrations/edit.css.scss )
Rails.application.config.assets.precompile += %w( sessions/new.css.scss )
Rails.application.config.assets.precompile += %w( invitations/new.css.scss )
Rails.application.config.assets.precompile += %w( television_programs/show.css.scss )
Rails.application.config.assets.precompile += %w( television_programs/new.css.scss )
Rails.application.config.assets.precompile += %w( television_programs/edit.css.scss )
Rails.application.config.assets.precompile += %w( television_programs/index.css.scss )
Rails.application.config.assets.precompile += %w( channels/show.css.scss )
Rails.application.config.assets.precompile += %w( channels/new.css.scss )
Rails.application.config.assets.precompile += %w( channels/edit.css.scss )
Rails.application.config.assets.precompile += %w( channels/index.css.scss )
Rails.application.config.assets.precompile += %w( administrator/index.css.scss )
Rails.application.config.assets.precompile += %w( user_activities/index.css.scss )
