# Setup

Place the `pipeline-pre-build.sh` file in the root of your project.

# Pre-Build Script

This script is designed to be run before building React Native apps in CI environments (e.g. Bitrise, Codemagic, Semaphore, GitHub Actions).

## Purpose

It prepares required files and environment configurations for a successful build, including secrets and environment variables.

## Responsibilities

The script performs the following tasks:

- Decodes the Android keystore and saves it to the specified path (`ANDROID_KEYSTORE_PATH`)
- Decodes the Google application credentials and writes them to the location defined by `GOOGLE_APPLICATION_CREDENTIALS`
- Generates an `.env` file from environment variables that match a given prefix (default: `RN_`)
- Creates a `sentry.properties` file used by Fastlane/Sentry CLI for both Android and iOS
- Injects the Mapbox download token into the `gradle.properties` file

## Environment Variables

The following environment variables must be defined in the CI environment:

- `ANDROID_KEYSTORE` – base64-encoded Android keystore
- `ANDROID_KEYSTORE_PATH` – target path for decoded keystore
- `GOOGLE_APPLICATION_CREDENTIALS_CONTENT` – base64-encoded JSON with Google credentials
- `GOOGLE_APPLICATION_CREDENTIALS` – output file path for decoded credentials
- `ENV_FILE_NAME` (optional) – name of the output .env file (default: `.env`)
- `ENV_WHITELIST` (optional) – regex for filtering env vars to include (default: `^RN_`)
- `SENTRY_URL`, `SENTRY_ORG`, `SENTRY_PROJECT`, `SENTRY_AUTH_TOKEN` – used to generate `sentry.properties`
- `MAPBOX_DOWNLOADS_TOKEN` – injected into `gradle.properties` for Mapbox SDK access

## Output

- `.env` and `sentry.properties` files in the root directory
- Platform-specific `sentry.properties` files in `ios/` and `android/`
- Updated `gradle.properties` with `MAPBOX_DOWNLOADS_TOKEN`
