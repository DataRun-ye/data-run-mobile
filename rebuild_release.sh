# dart fix --apply --code=unused_import
# dart fix --apply --code=always_use_package_imports
# dart fix --apply --code=prefer_single_quotes
# dart fix --apply --code=unnecessary_null_checks
# dart fix --apply --code=sort_constructors_first
# fvm flutter build appbundle --release

# split per platform ARM64, ARM, x86_64
#fvm flutter build apk --split-per-abi

# with obfuscate
#fvm flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols

# with split debug info, This tag can dramatically reduce code size [https://docs.flutter.dev/perf/app-size#breaking-down-the-size]
#fvm flutter build apk --split-debug-info=build/app/outputs/symbols

# for a specif platform
#fvm flutter build apk --target-platform android-arm64
#fvm flutter build apk --target-platform android-arm

# with size analyze *.json
#flutter build apk --target-platform android-arm64 --analyze-size


# with obfuscate

# fat apk for all platforms types ARM64, ARM, and x86_64
fvm flutter build apk

#fvm flutter create --platforms=windows .
#fvm flutter build windows