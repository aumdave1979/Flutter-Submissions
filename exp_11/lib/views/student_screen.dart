import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../controllers/auth_controller.dart';
import '../controllers/student_controller.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final AuthController _auth = AuthController();
  final StudentController _db = StudentController();
  String _searchQuery = '';

  void _showStudentDialog([
    String? id,
    String? currentName,
    String? currentRoll,
  ]) {
    final nameCtrl = TextEditingController(text: currentName);
    final rollCtrl = TextEditingController(text: currentRoll);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id == null ? 'Add Student' : 'Edit Student'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: rollCtrl,
              decoration: const InputDecoration(labelText: 'Roll Number'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (id == null) {
                _db.addStudent(nameCtrl.text, rollCtrl.text);
              } else {
                _db.updateStudent(id, nameCtrl.text, rollCtrl.text);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Display authenticated user information
        title: Text(_auth.currentUser?.email ?? 'Student DB'),
        actions: [
          // Implement logout
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _auth.logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search by Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) =>
                  setState(() => _searchQuery = val), // Implement search
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _db.getStudents(_searchQuery),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;

                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    return ListTile(
                      title: Text(doc['name']),
                      subtitle: Text('Roll: ${doc['rollNumber']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showStudentDialog(
                              doc.id,
                              doc['name'],
                              doc['rollNumber'],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _db.deleteStudent(doc.id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showStudentDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
