import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/user_service.dart';
import 'package:todo_list_project/features/auth/models/user.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  UserService? _userService;

  UserStoreBase(UserService userService) {
    _userService = userService;
  }

  @action
  Future<void> createUser(String uid, String name, String email, String password) async {
    Users user = Users(id: uid, name: name, email: email, password: password, type: '', token: '');

    print(user);

    await _userService!.addUser(user);
  }
}