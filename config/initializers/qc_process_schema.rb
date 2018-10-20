QC_PROCESS_SCHEMA = YAML.load_file(File.join(Rails.root, "config", "database_qc_process.yml"))[Rails.env.to_s]
