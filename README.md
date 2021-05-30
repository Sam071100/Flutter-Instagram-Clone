# Instagram_Clone

Hey, everyone. Here I will build the fully functional working instagram clone with the help of flutter and firebase. We will see the interaction of firestore database and manage the state of the App usng the BLoc architecture. BLoc is a state management library that allows us to separate our UI from our business logic. Understanding how to properly manage state is essential in building a production ready mobile App. We will aslo see topics such as keeping an maintable file structure, firebase authentications and cloud functions, navigations with named routes, asynchronous programming with streams and features, building our own custom widgets and more.

## My VSCode Extensions
 - Flutter
 - Dart
 - Awesome Flutter Snippets
 - Bracket Pair Colorizer 2
 - Material Icon Theme
 - Pubspec Assist
 - Bloc (by Felix Angelov)
 - Dart Data Class Generator

## Layout/Overview of this App
 -- Image to be added soon

## Flutter SDK Version
  After creating your project, change your Flutter sdk version to sdk: ">=2.7.0 < 3.0.0"  in your pubspec.yaml. Null safety is supported on sdk version 2.12.0 and above.

## Dependencies used:
 - flutter:
    sdk: flutter
 - cupertino_icons: ^1.0.2
 - cached_network_image: ^3.0.0  //Allows users to quickly load the images they download from the internet from their local device cache

 - enum_to_string: ^2.0.1 //Lets us easily convert enumerated values to string values
 - meta: ^1.3.0 //makes easier to import the meta package

 - cloud_firestore: ^2.2.0 //To use the firebase NOSQL database called Cloud Firestore
 - firebase_analytics: ^8.1.0 //for tracking the users action in the app
 - firebase_auth: ^1.2.0 //for authenticating users
 - firebase_core: ^1.2.0 //has core features for firebase that work with flutter
 - firebase_storage: ^8.1.0 //lets us store the media files such as images and videos
  
 - flutter_bloc: ^7.0.1 //BLoc for state management
 - equatable: ^2.0.2 //makes it super simple to compare objects with one another and works well with BLoc

 - image_cropper: ^1.4.0  //For cropping the selected image --> {Permission is required to be added in Android Manifest.xml}
 - image_picker: ^0.7.5+3 //For selecting images from the users library
  
 - intl: ^0.17.0 //Date formater package
 - timeago: ^3.0.2 // Calculates the difference in time between two specific dates and returns the string
 - uuid: ^3.0.4 //For generating unique identifier for photos to be stored in firebase storage

 ## Firebase Setup
 - Open 'https://console.firebase.google.com' and create new project
 - Write the name of your project, enable google analytics, select default account for Firebase and create project.
 - Click add App and select android app
  1. Register the app by entering the android package name which you can find under the android folder, then app and then build.gradle and then inside the defaultConfig you will find the applicationId which is the android package name for your app.
  2. Leave everything default and click Register app.
  3. Download google-services.json and drag it to the app folder in the android folder and ensure the name of the file is correct.
  4. Back in the build.gradle of app layer, inside the defaultConfig make the 'miniSdkVersion 21' and add 'multiDexEnabled true' as this is neccessary to run the Firebase on the android app and continue the setup in the firebase console.
  5. Follow the instructions on that page and act accordingly.
  6. For this project, I am going to use this four products. They are: Analytics, Authentication, Cloud Firestore and Cloud Storage. Follow the Firebase docs and add this to build.gradle of app layer in dependencies
  7. Now we are good to go, then finally go back to the Firebase console and select Authentication and under that enable the Email authentication.
  8. Now setting up the Cloud Firestore, create database and start in test mode and then select the Cloud Firestore location.
  9. Go the rules tab and update the rules as 'allow read, write : if reuest.auth.uid !=null;' that implies -->Whenever the user tries to read and write to our database we check if the request has the valid userid. If the userid is not valid then the user cannot read or write to the database.  
  10. Storage is where we are going to store all our users post and profile images.
  ## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
