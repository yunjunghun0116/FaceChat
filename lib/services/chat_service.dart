import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChatService<T> {
  Future<String?> startChat({required String user1Id, required String user2Id});
  Future<List<T>> getUserChat({required String userId});
  Future<T?> getChatRoom({required String chatId});
  Stream<QuerySnapshot<Map<String,dynamic>>> getChat({required String chatId});
  void sendText(
      {required String chatId, required String userId, required String text});
  void sendImage(
      {required String chatId,
      required String userId,
      required List<String> images});
}
