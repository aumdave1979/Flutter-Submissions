import 'package:flutter/material.dart';
import '../models/quote.dart';

class FavoriteQuotesScreen extends StatefulWidget {
  final List<Quote> favorites;
  final Function(Quote) onRemove;

  const FavoriteQuotesScreen({
    super.key,
    required this.favorites,
    required this.onRemove,
  });

  @override
  State<FavoriteQuotesScreen> createState() => _FavoriteQuotesScreenState();
}

class _FavoriteQuotesScreenState extends State<FavoriteQuotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Quotes')),
      body: widget.favorites.isEmpty
          ? const Center(child: Text('No favorite quotes saved yet.'))
          : ListView.builder(
              itemCount: widget.favorites.length,
              itemBuilder: (context, index) {
                final quote = widget.favorites[index];
                return ListTile(
                  title: Text('"${quote.text}"'),
                  subtitle: Text('- ${quote.author}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        widget.onRemove(quote);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
