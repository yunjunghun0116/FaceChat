import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  static final DataService _instance = DataService._internal();
  factory DataService() => _instance;
  DataService._internal();

  static const String collection = 'data';

  static Future<String?> getId({required String name}) async {
    try {
      String? id;
      await FirebaseFirestore.instance.runTransaction((transaction) async{
        DocumentReference documentReference = FirebaseFirestore.instance.collection(collection).doc(name);
        DocumentSnapshot snapshot = await transaction.get(documentReference);
        int count = snapshot.get('count');
        transaction.update(documentReference, {'count':count+1});

        id = '$name${count.toString().padLeft(8,'0')}';
      });

      return id;
    } catch (e) {
      log('FirebaseDataService - getId Failed : $e');
      return null;
    }
  }
}
