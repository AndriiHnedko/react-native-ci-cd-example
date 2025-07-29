# Setup

Place the `fastlane` folder and `Gemfile` file in the root of your project.  
If your React Native project already contains a default `Gemfile`, you may need to manually merge its content with the provided one.

Then run:

```bash
bundle install
```

# About

This folder contains Fastlane configuration for automating Android and iOS builds in CI environments.

## Overview

Fastlane is used to build, sign, and distribute both Android and iOS apps.  
It supports workflows for beta and release builds, and integrates with Firebase App Distribution and TestFlight.  
The configuration is intended to be reused across CI platforms such as Bitrise, GitHub Actions, Codemagic, and Semaphore.

## Android Lanes

- `beta`: Builds an APK and distributes it via Firebase App Distribution.
- `release`: Builds both APK and AAB artifacts. AAB is not distributed automatically.
- Internally uses `build`, `apk`, and `aab` private lanes for modular build steps.

## iOS Lanes

- `beta`: Builds and uploads the iOS app to TestFlight.
  - Automatically increments build number.
  - Uses Match for code signing (`type: appstore`, readonly for CI).
- `bump_build_number`: Increments the iOS build number.

## Common Lanes

- `notify_slack`: Sends a Slack message after the build using Bitrise environment variables.

## Required Environment Variables

See `.env.example` for required secrets such as keystore credentials, Firebase App ID, Apple team ID, and App Store Connect API keys.  
These should be securely configured in your CI platform.

## Artifacts

- Android APKs and AABs are copied to `BITRISE_DEPLOY_DIR` (in CI) or `artifacts/` locally.
- iOS builds are also saved to `BITRISE_DEPLOY_DIR` or `artifacts/`.

## Notes

- `version_code` is based on a timestamp (`date +"%Y%m%d%H%M%S"`).
- Code signing is handled via Fastlane Match.
- CI detection is based on `ENV["CI"]`.
