import 'package:cloud_firestore/cloud_firestore.dart';

class ChatController {
  // 1. Create a Firestore collection for chat messages
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    'chat_messages',
  );

  // 2. Retrieve messages using a Firestore stream
  Stream<QuerySnapshot> getMessagesStream() {
    return _collection.orderBy('timestamp', descending: true).snapshots();
  }

  // 3. Create and store new messages
  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
    await _collection.add({
      'text': text,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  // 4. Implement message editing (Update)
  Future<void> editMessage(String id, String newText) async {
    if (newText.trim().isEmpty) return;
    await _collection.doc(id).update({'text': newText});
  }

  // 5. Implement message deletion (Delete)
  Future<void> deleteMessage(String id) async {
    await _collection.doc(id).delete();
  }
}
