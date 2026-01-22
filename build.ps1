param(
    [string]$VcpkgRoot = $env:VCPKG_ROOT,
    [string]$Triplet = "x86-windows-static"
)

$ErrorActionPreference = "Stop"

if (-not $VcpkgRoot) {
    Write-Error "VCPKG_ROOT must be set or passed via -VcpkgRoot"
}

$Toolchain = "$VcpkgRoot/scripts/buildsystems/vcpkg.cmake"

cmake -S . -B build-win32 -G "Visual Studio 17 2022" -A Win32 `
    -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded `
    -DCMAKE_TOOLCHAIN_FILE="$Toolchain" `
    -DVCPKG_TARGET_TRIPLET="$Triplet" `
    -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON `
    -DBUILD_TESTING=OFF `
    -DCURL_USE_SCHANNEL=ON `
    -DCURL_USE_OPENSSL=OFF `
    -DUSE_NGHTTP2=ON `
    -DUSE_LIBIDN2=ON `
    -DCURL_USE_LIBPSL=ON `
    -DBUILD_SHARED_LIBS=ON `
    -DBUILD_STATIC_LIBS=ON `
    -DBUILD_CURL_EXE=ON `
    -DBUILD_STATIC_CURL=ON `
    -DCURL_STATIC_CRT=ON
cmake --build build-win32 --config Release
