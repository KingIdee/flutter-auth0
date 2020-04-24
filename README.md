# Flutter App with Auth0
A Flutter app that implements authentication with Auth0.

## Prerequisites
* You need the Flutter SDK installed on your machine. You can follow this [guide](https://flutter.dev/docs/get-started/install).
* You need one of [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/download).

## Setting up the project
* Login to your [Auth0 dashboard](https://manage.auth0.com/dashboard) or [create an account](https://auth0.com) if you don't have an Auth0 account yet.
* Create an API and note the Identifier name. The identifier name is also known as the API audience.
* Create a new native application on your dashboard. Note the client id of your application.
* Open the native application you just created and add this as your callback URL - `demo://YOUR_AUTH0_DOMAIN/dev.idee.flutterauth0/callback`. You will replace `YOUR_AUTH0_DOMAIN` with your Auth0 domain, usually something like `idee@auth0.com`.
* You also need to insert your Auth0 domain in the `android/app/src/main/AndroidManifest.xml` file and `ios/Runner/Info.plist` file.
* Finally, replace the credentials in the `lib/auth0_utils.dart` file with the credentials you got earlier.
* Run your app.
