UI = FastlaneCore::UI unless defined?(UI)

def lane_dev_upload
    scheme = "atmobeats-Dev"
    apply_version_and_build!(xcodeproj: "atmobeats.xcodeproj")
    match(type: "appstore")
    build_app(
        scheme: scheme,  
        configuration: "Release-Dev",
        export_method: "app-store",
        export_options: {
            provisioningProfiles: {
                "com.kuras.atmobeats.dev" => "match AppStore com.kuras.atmobeats.dev"
            }
        }
    )
    upload_to_testflight(app_identifier: "com.kuras.atmobeats.dev")
end