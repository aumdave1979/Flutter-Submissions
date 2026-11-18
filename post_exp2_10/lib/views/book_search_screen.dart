import 'package:flutter/material.dart';
import '../models/book.dart';
import '../controllers/book_controller.dart';

class BookSearchScreen extends StatefulWidget {
  const BookSearchScreen({super.key});

  @override
  State<BookSearchScreen> createState() => _BookSearchScreenState();
}

class _BookSearchScreenState extends State<BookSearchScreen> {
  final BookController _controller = BookController();
  final TextEditingController _searchController = TextEditingController();
  Future<List<Book>>? _booksFuture;

  void _search() {
    final keyword = _searchController.text.trim();
    if (keyword.isEmpty) return;

    setState(() {
      _booksFuture = _controller.searchBooks(keyword);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Book Search App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Enter book keyword...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(onPressed: _search, child: const Text('Search')),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _booksFuture == null
                  ? const Center(
                      child: Text('Enter a keyword to search books.'),
                    )
                  : FutureBuilder<List<Book>>(
                      future: _booksFuture,
                      builder: (context, snapshot) {
                        // 1. Loading State
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        // 2. Error State
                        if (snapshot.hasError) {
                          return Center(
                            child: Text(
                              '${snapshot.error}',
                              style: const TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        // 3. No-Result State
                        final books = snapshot.data ?? [];
                        if (books.isEmpty) {
                          return const Center(child: Text('No books found.'));
                        }
                        // 4. Scrollable List of Results
                        return ListView.builder(
                          itemCount: books.length,
                          itemBuilder: (context, index) {
                            final book = books[index];
                            return ListTile(
                              leading: const Icon(Icons.book),
                              title: Text(book.title),
                              subtitle: Text(book.author),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
