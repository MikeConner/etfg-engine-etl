API_SCHEMA = YAML.load_file(File.join(Rails.root, "config", "database_api.yml"))[Rails.env.to_s]
