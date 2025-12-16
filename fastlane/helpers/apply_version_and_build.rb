UI = FastlaneCore::UI unless defined?(UI)

def apply_version_and_build!(xcodeproj:)
  current_version = get_version_number(xcodeproj: xcodeproj)
  UI.message("Current version: #{current_version}")

  new_version = resolve_version(current_version)

  if new_version != current_version
    UI.message("Updating version to: #{new_version}")

    increment_version_number(
      version_number: new_version,
      xcodeproj: xcodeproj
    )

    # New version => reset build
    increment_build_number(
      build_number: 1,
      xcodeproj: xcodeproj
    )
  else
    UI.message("Keeping version: #{current_version}")

    # Same version => increment build
    increment_build_number(
      xcodeproj: xcodeproj
    )
  end

  new_version
end
