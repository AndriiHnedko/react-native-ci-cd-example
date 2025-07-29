#!/usr/bin/env bash

echo "Prepare android keystore"
echo "$ANDROID_KEYSTORE" | base64 -d > "$ANDROID_KEYSTORE_PATH"
echo "Prepare google application credentials"
echo "$GOOGLE_APPLICATION_CREDENTIALS_CONTENT" | base64 -d > "$GOOGLE_APPLICATION_CREDENTIALS"

echo "Prepare env file $ENV_FILE_NAME"
ENV_WHITELIST=${ENV_WHITELIST:-"^RN_"}
if [ -z "$ENV_FILE_NAME" ]; then
  ENV_FILE_NAME=.env
fi
set | grep -E "$ENV_WHITELIST" | sed 's/^RN_//g' >"$ENV_FILE_NAME"
cp "$ENV_FILE_NAME" .env
echo ".env ($ENV_FILE_NAME) created with contents:"
cat "$ENV_FILE_NAME"

# Generate sentry.properties file
printf "Generate sentry.properties file"
echo "defaults.url=$SENTRY_URL" >>sentry.properties
echo "defaults.org=$SENTRY_ORG" >>sentry.properties
echo "defaults.project=$SENTRY_PROJECT" >>sentry.properties
echo "auth.token=$SENTRY_AUTH_TOKEN" >>sentry.properties

cp sentry.properties "$SOURCE_DIRECTORY"/ios/sentry.properties
cp sentry.properties "$SOURCE_DIRECTORY"/android/sentry.properties

GRADLE_PROPERTIES=$SOURCE_DIRECTORY/android/gradle.properties

# Inject mapbox download token
echo "MAPBOX_DOWNLOADS_TOKEN=$MAPBOX_DOWNLOADS_TOKEN" >>"$GRADLE_PROPERTIES"
