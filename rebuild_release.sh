# dart fix --apply --code unused_import
# flutter build appbundle --release

# split per platform ARM64, ARM, x86_64
#flutter build apk --split-per-abi

# with obfuscate
#flutter build apk --obfuscate --split-debug-info=build/app/outputs/symbols

# with split debug info, This tag can dramatically reduce code size [https://docs.flutter.dev/perf/app-size#breaking-down-the-size]
#flutter build apk --split-debug-info=build/app/outputs/symbols

# for a specif platform
#flutter build apk --target-platform android-arm64
#flutter build apk --target-platform android-arm

# with size analyze *.json
#flutter build apk --target-platform android-arm64 --analyze-size


# with obfuscate

# fat apk for all platforms types ARM64, ARM, and x86_64
flutter build apk

#flutter create --platforms=windows .