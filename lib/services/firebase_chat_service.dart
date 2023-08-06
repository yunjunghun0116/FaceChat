import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facechat/models/personal_chat/personal_chat.dart';
import 'package:facechat/services/firebase_data_service.dart';

class FirebaseChatService {
  static final FirebaseChatService _instance = FirebaseChatService();
  factory FirebaseChatService() => _instance;

  static const String personalChatCollection = 'personalChat';
  static const String openChatCollection = 'openChat';

  /* Personal Chat */
  static Future<String?> startPersonalChat(
      {required String user1Id, required String user2Id}) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(personalChatCollection)
          .where(
            'userIdList',
            arrayContains: user1Id,
          )
          .get();
      List<QueryDocumentSnapshot> documentSnapshot =
          snapshot.docs.where((element) {
        List userIdList = element.get('userIdList');
        return userIdList.contains(user2Id);
      }).toList();
      // 이미 존재하는 채팅방의 경우
      if (documentSnapshot.isNotEmpty) {
        return documentSnapshot.first.id;
      }

      // 존재하지 않는 채팅방 -> 새로 만들어주어야함
      String? personalChatId =
          await FirebaseDataService.getId(name: personalChatCollection);

      if (personalChatId != null) {
        PersonalChat personalChat =
            PersonalChat(id: personalChatId, userIdList: [user1Id, user2Id]);

        await FirebaseFirestore.instance
            .collection(personalChatCollection)
            .doc(personalChatId)
            .set(personalChat.toJson());
      }
      return personalChatId;
    } catch (e) {
      log('FirebaseChatService - startPersonalChat Failed : $e');
      return null;
    }
  }

  static Future<List<PersonalChat>> getUserPersonalChat(
      {required String userId}) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(personalChatCollection)
          .where('userIdList', arrayContains: userId)
          .get();

      return snapshot.docs
          .map((document) =>
              PersonalChat.fromJson(document.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      log('FirebaseChatService - getUserPersonalChat Failed : $e');
      return [];
    }
  }

  static Future<PersonalChat?> getPersonalChat(
      {required String personalChatId}) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection(personalChatCollection)
          .doc(personalChatId)
          .get();

      if(snapshot.exists){
        return PersonalChat.fromJson(snapshot.data() as Map<String,dynamic>);
      }
      return null;
    } catch (e) {
      log('FirebaseChatService - getPersonalChat Failed : $e');
      return null;
    }
  }
}
