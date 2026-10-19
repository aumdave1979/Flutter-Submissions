import 'package:flutter/material.dart';

class DeveloperProfile extends StatelessWidget {
  const DeveloperProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text("Developer Profile")),
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
                            'Aum Dave',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            'B.Tech ICT Student',
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
                          'Skills',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: const [
                            SkillWidget(skill: 'Flutter'),
                            SkillWidget(skill: 'Dart'),
                            SkillWidget(skill: 'Python'),
                            SkillWidget(skill: 'Java'),
                            SkillWidget(skill: 'SQL'),
                          ],
                        ),
                        const SizedBox(height: 8),

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
