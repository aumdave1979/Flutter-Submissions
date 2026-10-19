import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  TextEditingController txtTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('Todo App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Row(
        children: [
          Expanded(
            child: TextField(
              controller: txtTitle,
              decoration: InputDecoration(
                hintText: "Enter title of Todo",
                labelText: "Title",
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              print(txtTitle.text);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
    return scaffold;
  }
}
