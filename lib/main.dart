import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:micix/components/home.dart';
import 'package:micix/components/login.dart';
import 'package:micix/components/signup.dart';
import 'components/onboarding.dart';
import 'components/selectlogin.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

Future<void> _changePersistence(FirebaseAuth auth) async {
  await auth.setPersistence(Persistence.LOCAL);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: (FirebaseAuth.instance.currentUser != null)
                ? HomePage()
                : OnboardingScreen(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete

        final auth = FirebaseAuth.instanceFor(
            app: Firebase.app(), persistence: Persistence.NONE);
        _changePersistence(auth);
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
          if (user == null) {
            print('User is currently signed out!');
          } else {
            print('User is signed in!');
            print(user);
          }
        });

        return HomePage();
      },
    );
  }
}
