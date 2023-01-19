# flutter_bloc Firestore Sample App

This sample app demonstrates how to use [flutter_bloc](https://pub.dev/packages/flutter_bloc) with [Cloud Firestore](https://firebase.google.com/docs/firestore/).

More specifically the app demonstrates how to [Authenticate with Firebase Anonymously](https://firebase.google.com/docs/auth/flutter/anonymous-auth) and how to [Get realtime updates with Cloud Firestore](https://firebase.google.com/docs/firestore/query-data/listen).

## Resources

- [Bloc Library: Basics & Beyond](https://www.youtube.com/watch?v=knMvKPKBzGE) by [Felix Angelov](https://github.com/felangel) - a good introduction to flutter_bloc
- [How to Get Data From Cloud Firestore using The BloC Pattern](https://www.youtube.com/watch?v=O8-Q6RyO8QY) - this was the main resource I used for this sample app, however since the sample app uses flutter_bloc 8.1.1 and this tutorial uses older version, I had to replace its [mapEventTostate](https://github.com/felangel/bloc/issues/2526) with on\<Event\> as explained in [v9 migration guide](https://bloclibrary.dev/#/migration?id=packagebloc-1)
- [Flutter bloc for begginners](https://medium.com/flutter-community/flutter-bloc-for-beginners-839e22adb9f5) - another good Flutter Bloc tutotrial that already uses the new API 
- [flutter_bloc with stream sample project](https://github.com/felangel/bloc/tree/master/examples/flutter_bloc_with_stream)
- [Firebase Authentication using Provider in Flutter](https://medium.flutterdevs.com/firebase-authentication-using-provider-in-flutter-522841a2ee4d)

## App Structure

The app consists of 2 screens - login & main. In the login screen a user can login to Firebase *annonymously*. This is just for demonstration purpose, the AuthService that handles all authentication logic can be extended easly to sign in using other methods.
Onced logged in the user is redirected to app's main page that consists of Users list, which is empty by default, and reload button.
Clicking on the button will trigger query from users collection, assuming such collection exists :)
Notice this is just a sample collection, not to be confused with Authentication's Users list.