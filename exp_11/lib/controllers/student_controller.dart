import 'package:cloud_firestore/cloud_firestore.dart';

class StudentController {
  final CollectionReference _db = FirebaseFirestore.instance.collection(
    'students',
  );

  // Create
  Future<void> addStudent(String name, String rollNumber) async {
    await _db.add({'name': name, 'rollNumber': rollNumber});
  }

  // Read (with Search capability)
  Stream<QuerySnapshot> getStudents([String searchQuery = '']) {
    if (searchQuery.isEmpty) {
      return _db.snapshots();
    } else {
      // Basic search operation
      return _db
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThanOrEqualTo: '$searchQuery\uf8ff')
          .snapshots();
    }
  }

  // Update
  Future<void> updateStudent(String id, String newName, String newRoll) async {
    await _db.doc(id).update({'name': newName, 'rollNumber': newRoll});
  }

  // Delete
  Future<void> deleteStudent(String id) async {
    await _db.doc(id).delete();
  }
}
