import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  const RecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Recipe App')),
        body: ListView(
          children: [
            // Featured recipe
            SizedBox(
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: Colors.orange),
                  const Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      'Featured Recipe: Pasta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Categories',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(
              height: 100,
              child: GridView.count(
                crossAxisCount: 3,
                children: const [
                  Card(child: Center(child: Text('Breakfast'))),
                  Card(child: Center(child: Text('Lunch'))),
                  Card(child: Center(child: Text('Dinner'))),
                ],
              ),
            ),

            // Recipe list
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Recipes',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Pasta'),
              subtitle: Text('Italian pasta recipe'),
            ),
            const ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Vegetable Salad'),
              subtitle: Text('Fresh and healthy salad'),
            ),
            const ListTile(
              leading: Icon(Icons.restaurant),
              title: Text('Pancakes'),
              subtitle: Text('Simple breakfast pancakes'),
            ),
          ],
        ),
      ),
    );
  }
}
