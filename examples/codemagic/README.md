# Setup

Place the `codemagic.yaml` file in the root of your project.

# About

This Codemagic configuration builds and distributes React Native apps for both Android and iOS using **Fastlane**.  
It supports environment-specific inputs, private library cloning, and caching for faster builds.

## Prepare environment

The `pipeline-pre-build.sh` script is used to set up the build environment.  
It includes installing Ruby dependencies and cloning private libraries (if not already cached).

## Install dependencies

Dependencies are installed and cached for:
- JavaScript via `yarn install`
- iOS Pods via `pod install`
- Fastlane via `bundle install`
- Gradle dependencies for Android

## Build

Two workflows are defined: `build_ios` and `build_android`, triggered manually through Codemagic UI or API.  
Each workflow installs dependencies and builds the app via Fastlane:

- Android builds are delivered to Firebase App Distribution.
- iOS builds are delivered to TestFlight.

Apple Developer Account is connected using an **App Store Connect API key**, and code signing is handled using **Fastlane Match**.

Environment management is handled via environment groups.
To configure develop, staging, or production environments, simply add the required variables to the corresponding group in the Codemagic UI.
