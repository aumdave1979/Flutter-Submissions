import 'package:flutter/material.dart';

class BusinessProfile extends StatelessWidget {
  const BusinessProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Business Profile")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: ClipOval(
                            child: Image.asset(
                              'assets/Aum.jpeg',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: Text(
                            'SportsSphere',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Ecosystem for SPorts',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 24),

                        const Text(
                          'About',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                const Icon(Icons.person_outline),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    'Engineering student interested in software development, '
                                    'AI/ML, IoT and Flutter.',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'Services',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: const [
                            SkillWidget(skill: 'Web Development'),
                            SkillWidget(skill: 'Mobile Apps'),
                            SkillWidget(skill: 'AI/ML'),
                            SkillWidget(skill: 'Cloud Solutions'),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 24),

                        const Text(
                          'Working Hours',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Monday - Friday: 9:00 AM - 6:00 PM'),
                                SizedBox(height: 8),
                                Text('Saturday: 10:00 AM - 2:00 PM'),
                                SizedBox(height: 8),
                                Text('Sunday: Closed'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 24),

                        const Text(
                          'Address',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: const [
                                Icon(Icons.location_on),
                                SizedBox(width: 12),
                                Flexible(
                                  child: Text(
                                    'Rajkot, Gujarat, India',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const ContactWidget(
                          icon: Icons.email,
                          text: 'aum@example.com',
                        ),
                        const SizedBox(height: 8),

                        const ContactWidget(
                          icon: Icons.phone,
                          text: '+91 XXXXX XXXXX',
                        ),

                        const SizedBox(height: 8),

                        const ContactWidget(icon: Icons.link, text: 'LinkedIn'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SkillWidget extends StatelessWidget {
  final String skill;

  const SkillWidget({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(skill, style: const TextStyle(color: Colors.white)),
    );
  }
}

class ContactWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactWidget({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(children: [Icon(icon), const SizedBox(width: 12), Text(text)]);
  }
}
