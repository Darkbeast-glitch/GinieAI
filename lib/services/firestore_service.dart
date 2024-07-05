import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveMessage(types.Message message, String userId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('messages')
        .doc(message.id)
        .set(message.toJson());
  }

  Future<void> deleteMessage(types.Message message, String userId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('messages')
        .doc(message.id)
        .delete();
  }

  Stream<List<types.Message>> getMessageStream(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => types.Message.fromJson(doc.data()))
          .toList();
    });
  }

  Future<bool> hasChatHistory(String userId) async {
    var querySnapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('messages')
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }
}
