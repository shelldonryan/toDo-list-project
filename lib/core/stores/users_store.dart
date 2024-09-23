import 'package:mobx/mobx.dart';
import 'package:todo_list_project/core/services/users_service.dart';
import 'package:uuid/uuid.dart';

part 'users_store.g.dart';

class UsersStore = _UsersStoreBase with _$UsersStore;

abstract class _UsersStoreBase with Store {
  final UsersService _usersService;
  final Uuid uuid = const Uuid();

  _UsersStoreBase(this._usersService);


}