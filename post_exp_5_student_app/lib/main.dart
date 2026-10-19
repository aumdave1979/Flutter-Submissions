import 'package:flutter/material.dart';
import 'package:post_exp_5_student_app/home_screen.dart';
import 'student_list_screen.dart';
import 'student_details_screen.dart';
import 'setting_screen.dart';

void main() {
  runApp(
    MaterialApp(
      home: const HomeScreen(),
      routes: {
        '/students': (context) => const StudentListScreen(),
        '/details': (context) => const StudentDetailsScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    ),
  );
}
