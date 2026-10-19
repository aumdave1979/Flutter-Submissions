import 'package:flutter/material.dart';

class StudentResultApp extends StatefulWidget {
  StudentResultApp({super.key});

  @override
  State<StudentResultApp> createState() {
    return _StudentResultApp();
  }
}

class _StudentResultApp extends State<StudentResultApp> {
  final nameController = TextEditingController();
  final mathController = TextEditingController();
  final englishController = TextEditingController();
  final scienceController = TextEditingController();
  final physicsController = TextEditingController();
  final computerController = TextEditingController();

  void calculateResult() {
    Map<String, int> marks = {
      'Maths': int.parse(mathController.text),
      'English': int.parse(englishController.text),
      'Science': int.parse(scienceController.text),
      'Physics': int.parse(physicsController.text),
      'Computer': int.parse(computerController.text),
    };

    print(marks);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text('Student Results App')),
              const SizedBox(height: 30),
              const Text('Student Name'),
              TextField(controller: nameController),
              const SizedBox(height: 30),
              const Text('Maths'),
              TextField(controller: mathController),
              const SizedBox(height: 30),
              const Text('English'),
              TextField(controller: englishController),
              const SizedBox(height: 30),
              const Text('Science'),
              TextField(controller: scienceController),
              const SizedBox(height: 30),
              const Text('Physics'),
              TextField(controller: physicsController),
              const SizedBox(height: 30),
              const Text('Computer'),
              TextField(controller: computerController),

              const SizedBox(height: 30),

              Center(
                child: ElevatedButton(
                  onPressed: calculateResult,
                  child: const Text('Calculate Result'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
