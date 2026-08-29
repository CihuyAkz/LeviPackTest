param(
  [string]$Abi = "arm64-v8a"
)

$ErrorActionPreference = "Stop"

if (-not $env:ANDROID_HOME) {
  throw "ANDROID_HOME is not set."
}

$ndk = Join-Path $env:ANDROID_HOME "ndk/28.2.13676358"
$toolchain = Join-Path $ndk "build/cmake/android.toolchain.cmake"

cmake -S . -B build -G Ninja `
  -DCMAKE_TOOLCHAIN_FILE="$toolchain" `
  -DANDROID_ABI="$Abi" `
  -DANDROID_PLATFORM=android-28 `
  -DMOD_ID="levi_bloom_noshader" `
  -DMOD_NAME="LeviBloom NoShader" `
  -DMOD_AUTHOR="OpenAI" `
  -DMOD_VERSION="0.1.0" `
  -DMOD_LIBRARY_NAME="levi_bloom_noshader" `
  -DMOD_MINECRAFT_VERSIONS='["1.21.*"]'

cmake --build build --target levi_package
Write-Host "Output: build/dist/levi_bloom_noshader/"

