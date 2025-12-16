UI = FastlaneCore::UI unless defined?(UI)

def apply_version_and_build!(xcodeproj:)
  current_version = get_marketing_version()
  UI.message("Current version: #{current_version}")

  new_version = resolve_version(current_version)

  if new_version != current_version
    UI.message("Updating version to: #{new_version}")

    set_marketing_version(version: new_version)
    increment_build_number(
      build_number: 1,
      xcodeproj: xcodeproj
    )
  else
    UI.message("Keeping version: #{current_version}")

    increment_build_number(
      xcodeproj: xcodeproj
    )
  end

  final_version = get_marketing_version()
  final_build = get_build_number(xcodeproj: xcodeproj)
  
  UI.important("🎯 Final version: #{final_version} (#{final_build})")
  new_version
end
