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
  ## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
