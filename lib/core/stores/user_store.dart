import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/user_service.dart';
import 'package:todo_list_project/features/auth/models/user.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  late UserService _userService;
  late Users user;

  @observable
  String username = "";

  @observable
  String userType = "";

  @observable
  String _currentUid = "";


  UserStoreBase(UserService userService) {
    _userService = userService;
  }

  Future<void> createUser(String uid, String name, String email, String password) async {
    if (uid.isEmpty || name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Invalid Parameters');
    }
    Users user = Users(id: uid, name: name, email: email, password: password, type: "", token: "");
    await _userService.addUser(user);
  }

  @action
  void cleanData() {
    username = "";
    userType = "";
    _currentUid = "";
  }

  @action
  Future<void> getUser(String uid) async {
    user = await _userService.getUser(uid);

    _currentUid = uid;
    username = user.name;
    userType = user.type;
  }
}