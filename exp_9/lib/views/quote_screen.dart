import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/quote.dart';
import '../controllers/quote_controller.dart';
import 'favorite_quotes_screen.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final QuoteController _controller = QuoteController();
  late Future<Quote?> _quoteFuture;

  final List<String> _categories = [
    'life',
    'success',
    'motivation',
    'education',
  ];
  String _selectedCategory = 'life';
  final List<Quote> _favorites = [];

  @override
  void initState() {
    super.initState();
    _quoteFuture = _controller.fetchQuote(_selectedCategory);
  }

  void _fetchNewQuote() {
    setState(() {
      _quoteFuture = _controller.fetchQuote(_selectedCategory);
    });
  }

  void _toggleFavorite(Quote quote) {
    setState(() {
      final exists = _favorites.any((q) => q.text == quote.text);
      if (exists) {
        _favorites.removeWhere((q) => q.text == quote.text);
      } else {
        _favorites.add(quote);
      }
    });
  }

  void _shareQuote(Quote quote) {
    final formattedMessage = '"${quote.text}"\n— ${quote.author}';
    Clipboard.setData(ClipboardData(text: formattedMessage));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to share:\n$formattedMessage')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FavoriteQuotesScreen(
                    favorites: _favorites,
                    onRemove: (quote) {
                      setState(() => _favorites.remove(quote));
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Category Dropdown
              DropdownButton<String>(
                value: _selectedCategory,
                items: _categories.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Text(cat.toUpperCase()),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _selectedCategory = val!;
                    _quoteFuture = _controller.fetchQuote(_selectedCategory);
                  });
                },
              ),
              const SizedBox(height: 20),

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
                    final isFav = _favorites.any((q) => q.text == quote.text);

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
                        const SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                isFav ? Icons.favorite : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () => _toggleFavorite(quote),
                            ),
                            IconButton(
                              icon: const Icon(Icons.share, color: Colors.blue),
                              onPressed: () => _shareQuote(quote),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
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
