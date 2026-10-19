import 'package:flutter/material.dart';

class StudentRegisScreen extends StatefulWidget {
  const StudentRegisScreen({super.key});

  @override
  State<StudentRegisScreen> createState() {
    return _StudentRegisScreenState();
  }
}

class _StudentRegisScreenState extends State<StudentRegisScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  String? selectedGender;
  bool flutterSelected = false;
  bool pythonSelected = false;
  bool javaSelected = false;
  double age = 18;
  bool notificationsEnabled = false;
  bool isSubmitted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Student Registration App')),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Gender',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'Male',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'Female',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('Other'),
                    value: 'Other',
                    groupValue: selectedGender,
                    onChanged: (value) {
                      setState(() {
                        selectedGender = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Skills',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  CheckboxListTile(
                    title: const Text('Flutter'),
                    value: flutterSelected,
                    onChanged: (value) {
                      setState(() {
                        flutterSelected = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Python'),
                    value: pythonSelected,
                    onChanged: (value) {
                      setState(() {
                        pythonSelected = value ?? false;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('Java'),
                    value: javaSelected,
                    onChanged: (value) {
                      setState(() {
                        javaSelected = value ?? false;
                      });
                    },
                  ),
                  Slider(
                    value: age,
                    min: 18,
                    max: 60,
                    divisions: 42,
                    label: age.round().toString(),
                    onChanged: (value) {
                      setState(() {
                        age = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Additional Preferences',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SwitchListTile(
                    title: const Text('Enable Notifications'),
                    value: notificationsEnabled,
                    onChanged: (value) {
                      setState(() {
                        notificationsEnabled = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      if (selectedGender == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select your gender'),
                          ),
                        );
                        return;
                      }

                      setState(() {
                        isSubmitted = true;
                      });
                    },
                    child: const Text('Submit'),
                  ),
                  if (isSubmitted) ...[
                    const SizedBox(height: 30),
                    const Text(
                      'Submitted Student Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text('Name: ${nameController.text}'),
                    Text('Email: ${emailController.text}'),
                    Text('Phone: ${phoneController.text}'),
                    Text('Gender: $selectedGender'),
                    Text('Age: ${age.round()}'),
                    Text(
                      'Notifications: ${notificationsEnabled ? 'Enabled' : 'Disabled'}',
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
