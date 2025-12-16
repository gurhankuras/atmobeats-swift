def resolve_version(current_version)
  env_version = ENV["NEW_VERSION"].to_s.strip
  return env_version unless env_version.empty?

  # CI ortamında prompt istemiyoruz
  return current_version if ENV["CI"]

  # Local prompt (aynı satırda)
  FastlaneCore::UI.message("Enter new version (leave empty to keep current): ")
  print "> "
  input = STDIN.gets&.strip.to_s

  input.empty? ? current_version : input
end
