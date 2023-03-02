import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Micix/components/cart.dart';
import 'package:Micix/components/checkout.dart';
import 'package:Micix/components/detail.dart';
import 'package:Micix/components/home.dart';
import 'package:Micix/components/login.dart';
import 'package:Micix/components/navigation.dart';
import 'package:Micix/components/order_done.dart';
import 'package:Micix/components/signup.dart';
import 'components/onboarding.dart';
import 'components/selectlogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

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
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: (FirebaseAuth.instance.currentUser != null)
                ? navigation()
                : OnboardingScreen(),
          );
        } else
          return CircularProgressIndicator();
      },
    );
  }
}
