# Setup

Place the `.semaphore` folder in the root of your project.

# About

This Semaphore CI/CD configuration builds and distributes React Native apps for both Android and iOS using **Fastlane**.  
It supports caching, private library cloning, and Fastlane-based delivery via Firebase App Distribution and TestFlight.

## Prepare environment

The `pipeline-pre-build.sh` script sets up the build environment.  
It includes Ruby setup (required for Fastlane), Node setup, and optionally clones private libraries if missing.

## Install dependencies

Each job installs and caches the following dependencies:
- JavaScript via `yarn install`
- iOS Pods via `pod install`
- Fastlane via `bundle install`
- Gradle dependencies during the Android job

## Build

Two platform-specific pipelines are defined:
- `build_ios.yml` – builds and distributes iOS beta builds
- `build_android.yml` – builds and distributes Android beta builds

These are triggered manually via promotions from the root `semaphore.yml` pipeline.

Builds are executed via Fastlane:
- **Android** builds are delivered to Firebase App Distribution
- **iOS** builds are delivered to TestFlight

Apple Developer Account is connected using an **App Store Connect API key**, and code signing is handled using **Fastlane Match**.

## Environment management

Secrets and environment-specific variables are managed through secret sets linked to deployment targets.
Each promotion (dev, stage, prod) uses its own deployment_target, allowing you to associate different secret sets and configuration values per environment.
