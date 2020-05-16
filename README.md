# Flutter App with Auth0
A Flutter app that implements authentication with Auth0.

## Prerequisites
* You need the Flutter SDK installed on your machine. You can follow this [guide](https://flutter.dev/docs/get-started/install).
* You need one of [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/download).

## Setting up the project
* Login to your [Auth0 dashboard](https://manage.auth0.com/dashboard) or [create an account](https://auth0.com) if you don't have an Auth0 account yet.
* Create a new native application on your dashboard. Note the client id of your application.
* Open the native application you just created and add this snippet as your callback URL:

```text
dev.idee.flutterauth0://${YOUR_AUTH0_DOMAIN}/ios/dev.idee.flutterauth0/callback,
dev.idee.flutterauth0://${YOUR_AUTH0_DOMAIN}/android/dev.idee.flutterauth0/callback
```

> Replace ${YOUR_AUTH0_DOMAIN} with your own Auth0 domain, usually something like `idee@auth0.com`.

* Replace the `YOUR_AUTH0_DOMAIN` placeholder in `lib/login.dart` and `android/app/src/main/AndroidManifest.xml` with your Auth0 domain too.
* Finally, replace the `YOUR_NATIVE_CLIENT_ID` in `lib/login.dart` with the client id of your Auth0 application which you got earlier.
* Run your app.
