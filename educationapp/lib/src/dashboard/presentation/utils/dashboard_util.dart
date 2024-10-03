import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educationapp/core/services/injection_container.dart';
import 'package:educationapp/src/auth/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DashboardUtil {
  const DashboardUtil._();

  static Stream<LocalUserModel> get userDataStream => sl<FirebaseFirestore>()
      .collection('users')
      .doc(sl<FirebaseAuth>().currentUser!.uid)
      .snapshots()
      .map((event) => LocalUserModel.fromMap(event.data()!));
}
