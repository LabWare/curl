# Set environment variables
$env:VCPKG_ROOT = "E:/devtools/vcpkg"
$env:VCPKG_TRIPLET = "x86-windows-static"

# Clean and reconfigure
Remove-Item build-win32-shared -Recurse -Force -ErrorAction SilentlyContinue

cmake -S . -B build-win32-shared `
  -G "Visual Studio 17 2022" `
  -A Win32 `
  -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded `
  -DCMAKE_TOOLCHAIN_FILE="$env:VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake" `
  -DVCPKG_TARGET_TRIPLET=$env:VCPKG_TRIPLET `
  "-DCMAKE_PREFIX_PATH=$env:VCPKG_ROOT/installed/$env:VCPKG_TRIPLET" `
  -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON `
  -DBUILD_SHARED_LIBS=ON `
  -DBUILD_STATIC_LIBS=OFF `
  -DBUILD_CURL_EXE=ON `
  -DBUILD_TESTING=OFF `
  -DCURL_USE_SCHANNEL=ON `
  -DCURL_USE_OPENSSL=OFF `
  -DUSE_NGHTTP2=ON `
  -DUSE_LIBIDN2=ON `
  -DCURL_USE_LIBPSL=ON `
  -DCURL_STATIC_CRT=ON

# Build
cmake --build build-win32-shared --config Release
