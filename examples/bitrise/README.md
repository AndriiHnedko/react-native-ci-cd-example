# Setup

Copy the contents of `bitrise.yml` into the configuration panel on bitrise.io, or place the file at the root of your project.

# About

All workflows in this setup are based on Fastlane, which handles building, code signing, and distribution processes across both platforms.

## Prepare environment

This workflow prepares the environment using the `pipeline-pre-build.sh` script.  
After that, private libraries are cloned and cached if not already present.

## Install dependencies

This workflow installs and caches `node_modules` and iOS `Pods`. During the Android build, Gradle dependencies are also cached.

## Linting

This workflow lints all pull requests. Only the modified lines are checked using `eslint-plugin-diff`.

## Build

Builds are triggered manually via the Bitrise API.

This workflow builds both iOS and Android apps for development, staging, and production environments using Fastlane.
All environments use Apple ID authentication for connecting the Apple Developer Account via the Bitrise web interface.
Code signing is handled using Fastlane Match.

Android builds are delivered to Firebase App Distribution, and iOS builds are delivered to TestFlight — both via Fastlane.
Additionally, build artifacts are stored in Bitrise for download.

A Slack notification is sent to the channel at the end of the build to indicate success or failure.

## Features

Apple Developer Account connection options:
- App Store Connect API key via Fastlane
- App Store Connect API key via Bitrise
- Apple ID via Bitrise

Code signing options for iOS:
- Built-in Bitrise code signing and certificate management
- Fastlane Match

There are three types of environment variables:
- Secret Environment Variables – Managed via the Bitrise web interface and shared across all workflows. It is recommended to use suffixes like DEV, STAGE, and PROD to differentiate environments.
- Project Environment Variables – Can be managed via the web interface or directly in the .yml file. These are stored in the .yml file.
- Workflow Environment Variables – Can also be defined in the web interface or in the .yml file, and are specific to individual workflows.

```yaml
app:
  envs: # project-level env vars
  - FASTLANE_XCODE_LIST_TIMEOUT: 120
  - FASTLANE_WORK_DIR: "."
    opts:
      is_expand: false
workflows:
  build_ios_dev:
    envs:
    - MATCH_PASSWORD: "$MATCH_PASSWORD_DEV" # example of using a secret env variable
    - RN_ENV: DEVELOPMENT # example of a regular env variable
      opts:
        is_expand: false
    #   add other env variables here
    steps:
    - bundle::build_ios: {}
    meta:
      bitrise.io:
        stack: osx-xcode-16.2.x
```

It is possible to manage bitrise.yml entirely from the web interface instead of storing it in the repository.
