import 'package:flutter/material.dart';
import '../models/quote.dart';
import '../controllers/quote_controller.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteController _controller = QuoteController();
  late Future<Quote?> _quoteFuture;

  @override
  void initState() {
    super.initState();
    _quoteFuture = _controller.fetchQuote();
  }

  void _fetchNewQuote() {
    setState(() {
      _quoteFuture = _controller.fetchQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quote App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Quote?>(
                future: _quoteFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    );
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Text('No quote returned from the server.');
                  } else {
                    final quote = snapshot.data!;
                    return Column(
                      children: [
                        Text(
                          '"${quote.text}"',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '- ${quote.author}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _fetchNewQuote,
                child: const Text('Get Another Quote'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
