import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> emailAnimation;
  late Animation<double> passwordAnimation;
  late Animation<double> buttonAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    emailAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.33),
    );

    passwordAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.33, 0.66),
    );

    buttonAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.66, 1.0),
    );

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        children: [
          FadeTransition(
            opacity: emailAnimation,
            child: TextField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
          ),
          FadeTransition(
            opacity: passwordAnimation,
            child: TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
          ),
          FadeTransition(
            opacity: buttonAnimation,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}
