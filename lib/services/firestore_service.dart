import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _ref =
      FirebaseFirestore.instance.collection('notes');

  // 🔹 Stream notes
  Stream<List<Map<String, dynamic>>> notesStream() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return const Stream.empty();

    return _ref
        .where('uid', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => {
                    ...doc.data(),
                    'id': doc.id,
                  })
              .toList(),
        );
  }

  // 🔹 Create / Update note (WITH CATEGORY)
  Future<void> saveNote(
    String title,
    String content,
    String category,
    String? id,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    if (id == null) {
      await _ref.add({
        'title': title,
        'content': content,
        'category': category,
        'uid': user.uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } else {
      await _ref.doc(id).update({
        'title': title,
        'content': content,
        'category': category,
      });
    }
  }

  // 🔹 Delete
  Future<void> deleteNote(String id) async {
    await _ref.doc(id).delete();
  }
}
