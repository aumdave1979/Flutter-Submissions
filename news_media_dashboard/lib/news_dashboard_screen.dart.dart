import 'package:flutter/material.dart';

class NewsDashboardScreen extends StatelessWidget {
  const NewsDashboardScreen({super.key});

  Future<void> _refreshNews() async {
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshNews,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            // Collapsible app bar
            const SliverAppBar(
              title: Text('News Dashboard'),
              expandedHeight: 150,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: ColoredBox(color: Colors.blue),
              ),
            ),

            // Collapsing welcome/profile section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const CircleAvatar(child: Icon(Icons.person)),
                    const SizedBox(width: 12),
                    const Text(
                      'Welcome to News',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Featured article using Stack
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      const Positioned(
                        left: 16,
                        bottom: 16,
                        child: Text(
                          'Featured News Article',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // News categories using SliverGrid and Card
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverGrid(
              delegate: SliverChildListDelegate([
                Card(child: Center(child: Text('World'))),
                Card(child: Center(child: Text('Sports'))),
                Card(child: Center(child: Text('Technology'))),
              ]),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.2,
              ),
            ),

            // News articles using SliverList and ListTile
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Latest News',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildListDelegate([
                const ListTile(
                  leading: Icon(Icons.article),
                  title: Text('Latest World News'),
                  subtitle: Text('World news summary'),
                ),
                const ListTile(
                  leading: Icon(Icons.sports),
                  title: Text('Latest Sports News'),
                  subtitle: Text('Sports news summary'),
                ),
                const ListTile(
                  leading: Icon(Icons.computer),
                  title: Text('Latest Technology News'),
                  subtitle: Text('Technology news summary'),
                ),
              ]),
            ),

            // Bottom spacing
            const SliverToBoxAdapter(child: SizedBox(height: 20)),
          ],
        ),
      ),
    );
  }
}
