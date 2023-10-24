// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAyRli9CgVzxcgnGlfheg-Ckqy4V1in9pM',
    appId: '1:922026563911:web:5554a94894b7f439ab9462',
    messagingSenderId: '922026563911',
    projectId: 'munchmate-9ad84',
    authDomain: 'munchmate-9ad84.firebaseapp.com',
    databaseURL: 'https://munchmate-9ad84-default-rtdb.firebaseio.com',
    storageBucket: 'munchmate-9ad84.appspot.com',
    measurementId: 'G-1075X665KT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBzANKTHGN0rn0D9hJCF4vzB4GNLqf3Q_0',
    appId: '1:922026563911:android:27e4bf5d5942a26cab9462',
    messagingSenderId: '922026563911',
    projectId: 'munchmate-9ad84',
    databaseURL: 'https://munchmate-9ad84-default-rtdb.firebaseio.com',
    storageBucket: 'munchmate-9ad84.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBbIRRDeolbZHNmEOoS-A8VtUPRBQutMaQ',
    appId: '1:922026563911:ios:da9de45ec2c86e8eab9462',
    messagingSenderId: '922026563911',
    projectId: 'munchmate-9ad84',
    databaseURL: 'https://munchmate-9ad84-default-rtdb.firebaseio.com',
    storageBucket: 'munchmate-9ad84.appspot.com',
    androidClientId: '922026563911-dg53u13oq537lo3tb84e60823kb7mt50.apps.googleusercontent.com',
    iosClientId: '922026563911-8nmo883ut1o1c65ot2lhcuebvtc620dn.apps.googleusercontent.com',
    iosBundleId: 'com.example.munchmateAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBbIRRDeolbZHNmEOoS-A8VtUPRBQutMaQ',
    appId: '1:922026563911:ios:da9de45ec2c86e8eab9462',
    messagingSenderId: '922026563911',
    projectId: 'munchmate-9ad84',
    databaseURL: 'https://munchmate-9ad84-default-rtdb.firebaseio.com',
    storageBucket: 'munchmate-9ad84.appspot.com',
    androidClientId: '922026563911-dg53u13oq537lo3tb84e60823kb7mt50.apps.googleusercontent.com',
    iosClientId: '922026563911-8nmo883ut1o1c65ot2lhcuebvtc620dn.apps.googleusercontent.com',
    iosBundleId: 'com.example.munchmateAdmin',
  );
}