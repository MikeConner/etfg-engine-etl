FEED_SCHEMA = YAML.load_file(File.join(Rails.root, "config", "database_feed.yml"))[Rails.env.to_s]
