def pre_build_checks()
    ensure_git_status_clean
    swiftlint(
        mode: :lint,
        strict: true
    )
end