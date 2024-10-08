import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diary_app/core/error/exceptions/exceptions.dart';
import 'package:diary_app/core/service_locator/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/diary_model.dart';

abstract class DiaryRemoteDataSource {
  Future<void> addDiaryEntry(DiaryModel diaryModel);
}

class DiaryRemoteDataSourceImpl implements DiaryRemoteDataSource {
  final FirebaseFirestore firestore;

  DiaryRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> addDiaryEntry(DiaryModel diaryModel) async {
    final currentUser = serviceLocator<FirebaseAuth>().currentUser;
    try {
      if (currentUser != null) {
        final DocumentReference<Map<String, dynamic>> reference = firestore
            .collection('users')
            .doc(currentUser.uid)
            .collection('diary')
            .doc(diaryModel.id); 

        await reference
            .set(diaryModel.toMap());
      }
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
