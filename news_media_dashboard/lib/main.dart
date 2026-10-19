import 'package:flutter/material.dart';

import 'news_dashboard_screen.dart.dart';

void main() {
  runApp(const NewsDashboardApp());
}

class NewsDashboardApp extends StatelessWidget {
  const NewsDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Dashboard',
      home: const NewsDashboardScreen(),
    );
  }
}
