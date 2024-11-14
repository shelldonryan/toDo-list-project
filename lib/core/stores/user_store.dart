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

  @observable
  List<Users> userList = [];

  @computed
  List<Users> get supportUsers {
    return List<Users>.of(userList.where((user) => user.type == "support"));
  }

  @computed
  List<Users> get developerUsers {
    return List<Users>.of(userList.where((user) => user.type == "developer" && user.id != _currentUid));
  }


  UserStoreBase(UserService userService) {
    _userService = userService;
  }

  @action
  Future<void> createUser(String uid, String name, String email, String password) async {
    if (uid.isEmpty || name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Invalid Parameters');
    }

    Users user = Users(id: uid, name: name, email: email, password: password, type: "support", token: "");
    await _userService.addUser(user);
    userList.add(user);
  }

  @action
  Future<void> updateType(String uid, String type) async {
    if (uid.isEmpty) {
      throw Exception('Invalid Parameters');
    }

    int index = userList.indexWhere((user) => user.id == uid);
    if (index == -1) {
      throw Exception('User not found');
    }

    Users userToUpdate = userList[index];
    userToUpdate.type = type;

    try {
      await _userService.updateUser (userToUpdate);
      userList = await _userService.getUsers();
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @action
  void cleanData() {
    username = "";
    userType = "";
    _currentUid = "";
  }

  @action
  Future<void> getUserAccount(String uid) async {
    user = await _userService.getUser(uid);
    userList = await _userService.getUsers();

    _currentUid = uid;
    username = user.name;
    userType = user.type;
  }
}