import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() {
    return _FeedbackScreenState();
  }
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  double rating = 1;
  String? recommendation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback')),
      body: Column(
        children: [
          Text('Rating: ${rating.round()}'),
          Slider(
            value: rating,
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (value) {
              setState(() {
                rating = value;
              });
            },
          ),
          TextField(decoration: const InputDecoration(labelText: 'Comments')),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: 'Category'),
            items: const [
              DropdownMenuItem(value: 'Service', child: Text('Service')),
              DropdownMenuItem(value: 'App', child: Text('App')),
              DropdownMenuItem(value: 'Other', child: Text('Other')),
            ],
            onChanged: (value) {},
          ),
          RadioListTile<String>(
            title: const Text('Yes'),
            value: 'Yes',
            groupValue: recommendation,
            onChanged: (value) {
              setState(() {
                recommendation = value;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('No'),
            value: 'No',
            groupValue: recommendation,
            onChanged: (value) {
              setState(() {
                recommendation = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
