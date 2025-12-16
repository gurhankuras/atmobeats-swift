def get_marketing_version()
  project_file = "../atmobeats.xcodeproj/project.pbxproj"
  content = File.read(project_file)  
  match = content.match(/MARKETING_VERSION = ([^;]+);/)
  
  if match
    version = match[1].strip
    UI.message("📖 Current MARKETING_VERSION: #{version}")
    version
  else
    UI.error("❌ MARKETING_VERSION not found in project")
    nil
  end
end

def set_marketing_version(version:)
  project_file = "../atmobeats.xcodeproj/project.pbxproj"
  content = File.read(project_file)
  
  # Tüm MARKETING_VERSION satırlarını güncelle
  updated_content = content.gsub(
    /MARKETING_VERSION = [^;]+;/,
    "MARKETING_VERSION = #{version};"
  )
  
  File.write(project_file, updated_content)
  UI.success("✅ MARKETING_VERSION set to: #{version}")
end