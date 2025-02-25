// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyCYte5CXXg-U8OGgdaCv6BdvxBdkOwr6HM',
    appId: '1:280829052207:web:c29b25e28dfba2197d4dda',
    messagingSenderId: '280829052207',
    projectId: 'feast-fit',
    authDomain: 'feast-fit.firebaseapp.com',
    storageBucket: 'feast-fit.firebasestorage.app',
    measurementId: 'G-KHWJTTQRV6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC_QPX9bHqY0kXTtAfzv6ONigBA6_c9NZc',
    appId: '1:280829052207:android:86648cae0d94f22a7d4dda',
    messagingSenderId: '280829052207',
    projectId: 'feast-fit',
    storageBucket: 'feast-fit.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgI6MWfPeWmmXubWUefRioD7S1bajQjOw',
    appId: '1:280829052207:ios:2bed1cc5ed72223b7d4dda',
    messagingSenderId: '280829052207',
    projectId: 'feast-fit',
    storageBucket: 'feast-fit.firebasestorage.app',
    iosBundleId: 'com.example.feastFit',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgI6MWfPeWmmXubWUefRioD7S1bajQjOw',
    appId: '1:280829052207:ios:2bed1cc5ed72223b7d4dda',
    messagingSenderId: '280829052207',
    projectId: 'feast-fit',
    storageBucket: 'feast-fit.firebasestorage.app',
    iosBundleId: 'com.example.feastFit',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCYte5CXXg-U8OGgdaCv6BdvxBdkOwr6HM',
    appId: '1:280829052207:web:e16e503c3780340a7d4dda',
    messagingSenderId: '280829052207',
    projectId: 'feast-fit',
    authDomain: 'feast-fit.firebaseapp.com',
    storageBucket: 'feast-fit.firebasestorage.app',
    measurementId: 'G-E68ENWS7VQ',
  );
}
