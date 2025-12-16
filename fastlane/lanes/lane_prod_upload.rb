UI = FastlaneCore::UI unless defined?(UI)

def lane_prod_upload
  scheme = "atmobeats-Prod"
  apply_version_and_build!(xcodeproj: "atmobeats.xcodeproj")
  match(type: "appstore")
  build_app(
    scheme: scheme,
    configuration: "Release-Prod",
    export_method: "app-store",
    export_options: {
        provisioningProfiles: {
            "com.kuras.atmobeats" => "match AppStore com.kuras.atmobeats"
        }
    }
  )

  upload_to_app_store(
    app_identifier: "com.kuras.atmobeats",
    skip_metadata: true,
    skip_screenshots: true,
    submit_for_review: false,
    precheck_include_in_app_purchases: false
  )

  UI.success("Uploaded to App Store Connect (not submitted for review).")
end