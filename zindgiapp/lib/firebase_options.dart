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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB1VY3gWFyCEvAb1PqIzaLSrvt0bRbdwjI',
    appId: '1:853146623270:web:f700f8f4baba173018f5e7',
    messagingSenderId: '853146623270',
    projectId: 'zindgi-app',
    authDomain: 'zindgi-app.firebaseapp.com',
    storageBucket: 'zindgi-app.appspot.com',
    measurementId: 'G-RMNGBQTY8Y',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsqkcAcLMnXHT7OerJWsJX4jFsi0nCXkU',
    appId: '1:853146623270:android:afea64072d48504718f5e7',
    messagingSenderId: '853146623270',
    projectId: 'zindgi-app',
    storageBucket: 'zindgi-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTCprAYV1J3rxY8o3XCZk8Cwikm2fFa-g',
    appId: '1:853146623270:ios:5425f25e8c4956aa18f5e7',
    messagingSenderId: '853146623270',
    projectId: 'zindgi-app',
    storageBucket: 'zindgi-app.appspot.com',
    iosBundleId: 'com.example.zindgiapp',
  );
}
