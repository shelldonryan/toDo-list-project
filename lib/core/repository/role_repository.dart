import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_project/core/database/db_firestore.dart';

class RoleRepository {
  late FirebaseFirestore dbFirestore;

  RoleRepository() {
    _startFirestore();
  }

  _startFirestore() {
    dbFirestore = DBFirestore.get();
  }

  Future<void> create(String uid, String type) async {
    await dbFirestore.collection('roles').doc(uid).set({
      'role': type,
    });
  }

  Future<String> getByUser(String uid) async {
    try {
      DocumentSnapshot doc =
          await dbFirestore.collection('roles').doc(uid).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        return data['role'] ?? 'Essa role não existe';
      } else {
        return 'Esse documento não existe';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<void> update(String uid, String type) async {
    await dbFirestore.collection('roles').doc(uid).update({
      'role': type,
    });
  }

  Future<void> delete(String uid) async {
    try {
      await dbFirestore.collection('roles').doc(uid).delete();
    } catch (e) {
      throw new Exception("Error: $e : $uid");
    }
  }
}
