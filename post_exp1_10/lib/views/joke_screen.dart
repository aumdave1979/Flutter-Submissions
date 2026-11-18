import 'package:flutter/material.dart';
import '../models/joke.dart';
import '../controllers/joke_controller.dart';

class JokeScreen extends StatefulWidget {
  const JokeScreen({super.key});

  @override
  State<JokeScreen> createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final JokeController _controller = JokeController();
  late Future<Joke?> _jokeFuture;

  @override
  void initState() {
    super.initState();
    _jokeFuture = _controller.fetchJoke();
  }

  void _fetchNewJoke() {
    setState(() {
      _jokeFuture = _controller.fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Random Jokes App')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Joke?>(
                future: _jokeFuture,
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
                    return const Text('No joke returned from the server.');
                  } else {
                    final joke = snapshot.data!;
                    return Column(
                      children: [
                        Text(
                          joke.setup,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          joke.punchline,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _fetchNewJoke,
                child: const Text('Get Another Joke'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
