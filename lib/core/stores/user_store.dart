import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/user_service.dart';
import 'package:todo_list_project/features/auth/models/user.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  UserService? _userService;

  @observable
  Users? user;

  UserStoreBase(UserService userService) {
    _userService = userService;
  }

  @action
  Future<void> createUser(String uid, String name, String email, String password) async {
    if (uid.isEmpty || name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Invalid Parameters');
    }

    Users user = Users(id: uid, name: name, email: email, password: password, type: "", token: "");
    await _userService!.addUser(user);
  }

  @action
  Future<void> getUser(String uid) async {
    if (uid.isEmpty) {
      throw Exception('Parâmetro de entrada inválido');
    }

    try {
      user = await _userService!.getUser(uid);
    } catch (e) {
      throw Exception("Error get user: $uid");
    }
  }
}