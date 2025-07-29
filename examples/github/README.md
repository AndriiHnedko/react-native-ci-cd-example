# Setup

Place the `.github` folder in the root of your project.

# About

This GitHub Actions configuration builds and distributes React Native apps for both Android and iOS using **Fastlane**.  
It supports environment-specific secrets, separate workflows per platform.

## Prepare environment

The `pipeline-pre-build.sh` script is used to set up the build environment.  
It includes Ruby setup (required for Fastlane) when using the Ubuntu runner.

## Build

Two workflows are defined: `build-ios-beta` and `build-android-beta`.  
Each workflow is triggered by a tag that matches one of the following patterns:
- Android: `android-beta/v*`
- iOS: `ios-beta/v*`

Builds are executed via Fastlane:
- **Android** builds are delivered to Firebase App Distribution
- **iOS** builds are delivered to TestFlight

Apple Developer Account is connected using an **App Store Connect API key**, and code signing is handled using **Fastlane Match**.
