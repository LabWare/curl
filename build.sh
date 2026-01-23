#!/bin/bash
set -e

VCPKG_ROOT="${VCPKG_ROOT:-$1}"
TRIPLET="${2:-x86-windows-static}"

if [[ -z "$VCPKG_ROOT" ]]; then
    echo "Error: VCPKG_ROOT must be set or passed as first argument" >&2
    exit 1
fi

TOOLCHAIN="$VCPKG_ROOT/scripts/buildsystems/vcpkg.cmake"
PREFIX="$VCPKG_ROOT/installed/$TRIPLET"

cmake -S . -B build-win32 -G "Visual Studio 17 2022" -A Win32 \
    -DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded \
    "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN" \
    "-DCMAKE_PREFIX_PATH=$PREFIX" \
    "-DVCPKG_TARGET_TRIPLET=$TRIPLET" \
    -DCMAKE_FIND_PACKAGE_PREFER_CONFIG=ON \
    -DBUILD_TESTING=OFF \
    -DCURL_USE_SCHANNEL=ON \
    -DCURL_USE_OPENSSL=OFF \
    -DUSE_NGHTTP2=ON \
    -DUSE_LIBIDN2=ON \
    -DCURL_USE_LIBPSL=ON \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=ON \
    -DBUILD_CURL_EXE=ON \
    -DBUILD_STATIC_CURL=ON \
    -DCURL_STATIC_CRT=ON \
    -DCURL_STATIC_DEPS=ON

cmake --build build-win32 --config Release
