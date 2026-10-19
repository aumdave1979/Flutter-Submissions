import 'package:flutter/material.dart';

class TravelDashboardScreen extends StatelessWidget {
  const TravelDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Travel Dashboard')),
        body: ListView(
          children: [
            // Featured location
            SizedBox(
              height: 150,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: Colors.blueGrey),
                  const Positioned(
                    left: 16,
                    bottom: 16,
                    child: Text(
                      'Explore the Mountains',
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
                  Card(child: Center(child: Text('Mountains'))),
                  Card(child: Center(child: Text('Beaches'))),
                  Card(child: Center(child: Text('Cities'))),
                ],
              ),
            ),

            // Destination list
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Popular Destinations',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            const ListTile(
              leading: Icon(Icons.landscape),
              title: Text('Manali'),
              subtitle: Text('Mountains and scenic views'),
            ),
            const ListTile(
              leading: Icon(Icons.beach_access),
              title: Text('Goa'),
              subtitle: Text('Beaches and coastal scenery'),
            ),
            const ListTile(
              leading: Icon(Icons.location_city),
              title: Text('Jaipur'),
              subtitle: Text('Historic forts and palaces'),
            ),
          ],
        ),
      ),
    );
  }
}
