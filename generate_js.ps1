# Remove existing worker files
Remove-Item -Path "web/worker.dart.js" -ErrorAction SilentlyContinue
Remove-Item -Path "web/worker.dart.min.js" -ErrorAction SilentlyContinue

# Run the build runner for development build
dart run build_runner build --delete-conflicting-outputs -o web:build/web/

# Copy the generated worker file
Copy-Item -Path "build/web/worker.dart.js" -Destination "web/worker.dart.js" -Force

# Remove the build directory
Remove-Item -Path "build/web" -Recurse -Force

# Run the build runner for release build
dart run build_runner build --release --delete-conflicting-outputs -o web:build/web/

# Copy the minified worker file
Copy-Item -Path "build/web/worker.dart.js" -Destination "web/worker.dart.min.js" -Force

# Remove the build directory
Remove-Item -Path "build/web" -Recurse -Force
