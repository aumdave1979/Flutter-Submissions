import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'controllers/auth_controller.dart';
import 'views/auth_screen.dart';
import 'views/student_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Management',
      // StreamBuilder restricts screens based on authentication state
      home: StreamBuilder(
        stream: AuthController().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const StudentScreen(); // User is logged in
          }
          return const AuthScreen(); // User is NOT logged in
        },
      ),
    );
  }
}
