Rails.application.config.assets.precompile += %w( tv.css )
Rails.application.config.assets.precompile += %w( mediaelementplayer.css )
Rails.application.config.assets.precompile += %w( animate.css )
Rails.application.config.assets.precompile += %w( tv.js )
Rails.application.config.assets.precompile += %w( jquery.cycle2.min.js )

#JS e CSS para 2048
Rails.application.config.assets.precompile += %w( bind_polyfill.js )
Rails.application.config.assets.precompile += %w( classlist_polyfill.js )
Rails.application.config.assets.precompile += %w( animframe_polyfill.js )
Rails.application.config.assets.precompile += %w( keyboard_input_manager.js )
Rails.application.config.assets.precompile += %w( html_actuator.js )
Rails.application.config.assets.precompile += %w( grid.js )
Rails.application.config.assets.precompile += %w( tile.js )
Rails.application.config.assets.precompile += %w( local_storage_manager.js )
Rails.application.config.assets.precompile += %w( game_manager.js )
Rails.application.config.assets.precompile += %w( application2048.js )

Rails.application.config.assets.precompile += %w( main2048.css )