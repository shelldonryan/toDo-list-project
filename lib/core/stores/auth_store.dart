import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @observable
  User? _firebaseUser;

  @observable
  bool userIsAuth = false;

  @observable
  bool isLoading = false;

  AuthStoreBase() {

    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        userIsAuth = true;
        _firebaseUser = _firebaseAuth.currentUser;
      } else {
        userIsAuth = false;
        _firebaseUser = null;
      }
    });
  }

  User? get user => _firebaseUser;

  @action
  Future<String?> signup(String email, String password) async {
    try {
      isLoading = true;

      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      isLoading = false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      return e.message;
    }
    return null;
  }

  @action
  Future<String?> signin(String email, String password) async {
    try {
      isLoading = true;

      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      isLoading = false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      return e.message;
    }
    return null;
  }

  @action
  Future<String?> logout() async {
    try {
      isLoading = true;

      await _firebaseAuth.signOut();

      isLoading = false;
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      return e.message;
    }
    return null;
  }
}
