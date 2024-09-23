import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/user_service.dart';
import 'package:todo_list_project/features/auth/models/user.dart';
import 'package:uuid/uuid.dart';

part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  final UserService _userService;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Uuid uuid = const Uuid();

  @observable
  User? _firebaseUser;

  @observable
  bool userIsAuth = false;

  @observable
  bool isLoading = false;

  AuthStoreBase(this._userService) {
    _firebaseUser = _firebaseAuth.currentUser;

    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        userIsAuth = true;
      } else {
        userIsAuth = false;
      }
    });
  }

  User? get user => _firebaseUser;

  Future<bool> signup(String username, String password, String confirmPassword,
      String email) async {
    String id = uuid.v4();

    try {
      if (password == confirmPassword) {
        isLoading = true;

        await _userService.addUser(Users(
            id: id,
            name: username,
            password: password,
            email: email,
            type: 'support',
            token: ''));

        await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        isLoading = false;

        return true;
      }

      return false;
    } catch (e) {
      isLoading = false;
      return false;
    }
  }

  Future<void> signin(String email, String password) async {
    try {
      isLoading = true;

      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading = true;

      await _firebaseAuth.signOut();

      isLoading = false;
    } catch (e) {
      isLoading = false;
    }
  }
}
