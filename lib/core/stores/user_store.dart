import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/repository/role_repository.dart';
import 'package:todo_list_project/core/repository/user_repository.dart';
import 'package:todo_list_project/features/auth/models/user.dart';

part 'user_store.g.dart';

class UserStore = UserStoreBase with _$UserStore;

abstract class UserStoreBase with Store {
  late UserRepository _userRepository;
  late Users user;

  @observable
  String username = "";

  @observable
  String userType = "";

  @observable
  String currentUid = "";

  @observable
  List<Users> userList = [];

  @computed
  List<Users> get supportUsers {
    return List<Users>.of(userList.where((user) => user.type == "support"));
  }

  @computed
  List<Users> get developerUsers {
    return List<Users>.of(userList
        .where((user) => user.type == "developer" && user.id != currentUid));
  }

  UserStoreBase(UserRepository userService) {
    _userRepository = userService;
  }

  @action
  Future<void> createUser(String uid, String name, String email,
      String password, String type) async {
    if (uid.isEmpty || name.isEmpty || email.isEmpty || password.isEmpty) {
      throw Exception('Invalid Parameters');
    }

    Users newUser = Users(
        id: uid,
        name: name,
        email: email,
        password: password,
        type: type,
        token: "");
    await _userRepository.addUser(newUser);
    userList.add(newUser);
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
      await _userRepository.updateUser(userToUpdate);
      userList = await _userRepository.getUsers();
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  @action
  Future<void> deleteUser() async {
    try {
      await _userRepository.deleteUser(currentUid);
      userList = await _userRepository
          .getUsers(); // Atualiza a lista após excluir o usuário
    } catch (e) {
      throw Exception("Failed to delete user: $e");
    }
  }

  @action
  Future<void> getUserAccount(String uid) async {
    try {
      user = await _userRepository.getUser(uid);
      userList = await _userRepository.getUsers();

      currentUid = uid;
      username = user.name;

      final data = await RoleRepository().getByUser(uid);

      if (data != "support" && data != "developer") {
        throw Exception("User does not have a valid role");
      }

      userType = data;
    } catch (e) {
      throw Exception("Failed to get user account: $e");
    }
  }

  @action
  void cleanData() {
    username = "";
    userType = "";
    currentUid = "";
  }
}
