import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/app_localizations.dart';

class EventPlannerScreen extends StatelessWidget {
  const EventPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final events = [
      {'name': 'College Festival', 'date': DateTime(2026, 11, 15)},
      {'name': 'Sports Day', 'date': DateTime(2026, 12, 5)},
      {'name': 'Project Exhibition', 'date': DateTime(2027, 1, 10)},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Event Planner')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          final date = event['date'] as DateTime;

          return ListTile(
            leading: const Icon(Icons.event),
            title: Text(event['name'] as String),
            subtitle: Text(DateFormat.yMMMMd(locale).format(date)),
          );
        },
      ),
    );
  }
}
