# Setup

Place the `.circleci` folder in the root of your project.

# About

This CircleCI pipeline is designed for building and testing React Native apps across Android and iOS platforms.  
It uses **Fastlane** to manage building and distribution workflows, and integrates **Detox** for end-to-end testing on iOS.

## Prepare environment

Pre-build steps are defined to run shared setup logic, such as environment setup or dependency resolution.

## Install dependencies

Dependencies are installed and cached separately for JavaScript (`yarn install`), iOS (`pod install`), and Fastlane (`bundle install`).  
Gradle dependencies for Android are also resolved and cached to improve performance on repeated builds.

## Build

Builds are automatically triggered by version tags that match specific patterns:
- Android builds: `android-beta/v*`
- iOS builds: `ios-beta/v*`

Android builds are delivered to Firebase App Distribution, and iOS builds to TestFlight using Fastlane.
Apple Developer Account is connected using an **App Store Connect API** key via Fastlane, and code signing is handled with **Fastlane Match**.

## Detox tests

The iOS build includes Detox configuration and steps for building and running end-to-end tests in headless mode.

## Features

- Apple Developer connection via App Store Connect API key (Fastlane only)
- Code signing via Fastlane Match
