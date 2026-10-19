import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:cupertino_icons/cuperino_icons.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calc')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: () {}, child: Text('AC')),
                ElevatedButton(onPressed: () {}, child: Icon(Icons.close)),
                ElevatedButton(onPressed: () {}, child: Icon(Icons.percent)),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(CupertinoIcons.divide),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('7')),
                ElevatedButton(onPressed: () {}, child: Text('8')),
                ElevatedButton(onPressed: () {}, child: Text('9')),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(CupertinoIcons.multiply),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('4')),
                ElevatedButton(onPressed: () {}, child: Text('5')),
                ElevatedButton(onPressed: () {}, child: Text('6')),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(CupertinoIcons.minus),
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(onPressed: () {}, child: Text('1')),
                ElevatedButton(onPressed: () {}, child: Text('2')),
                ElevatedButton(onPressed: () {}, child: Text('3')),
                ElevatedButton(
                  onPressed: () {},
                  child: Icon(CupertinoIcons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
