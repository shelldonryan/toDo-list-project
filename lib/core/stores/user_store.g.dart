// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  Computed<List<Users>>? _$supportUsersComputed;

  @override
  List<Users> get supportUsers => (_$supportUsersComputed ??=
          Computed<List<Users>>(() => super.supportUsers,
              name: 'UserStoreBase.supportUsers'))
      .value;
  Computed<List<Users>>? _$developerUsersComputed;

  @override
  List<Users> get developerUsers => (_$developerUsersComputed ??=
          Computed<List<Users>>(() => super.developerUsers,
              name: 'UserStoreBase.developerUsers'))
      .value;

  late final _$usernameAtom =
      Atom(name: 'UserStoreBase.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$userTypeAtom =
      Atom(name: 'UserStoreBase.userType', context: context);

  @override
  String get userType {
    _$userTypeAtom.reportRead();
    return super.userType;
  }

  @override
  set userType(String value) {
    _$userTypeAtom.reportWrite(value, super.userType, () {
      super.userType = value;
    });
  }

  late final _$_currentUidAtom =
      Atom(name: 'UserStoreBase._currentUid', context: context);

  @override
  String get _currentUid {
    _$_currentUidAtom.reportRead();
    return super._currentUid;
  }

  @override
  set _currentUid(String value) {
    _$_currentUidAtom.reportWrite(value, super._currentUid, () {
      super._currentUid = value;
    });
  }

  late final _$userListAtom =
      Atom(name: 'UserStoreBase.userList', context: context);

  @override
  List<Users> get userList {
    _$userListAtom.reportRead();
    return super.userList;
  }

  @override
  set userList(List<Users> value) {
    _$userListAtom.reportWrite(value, super.userList, () {
      super.userList = value;
    });
  }

  late final _$createUserAsyncAction =
      AsyncAction('UserStoreBase.createUser', context: context);

  @override
  Future<void> createUser(
      String uid, String name, String email, String password) {
    return _$createUserAsyncAction
        .run(() => super.createUser(uid, name, email, password));
  }

  late final _$updateTypeAsyncAction =
      AsyncAction('UserStoreBase.updateType', context: context);

  @override
  Future<void> updateType(String uid, String type) {
    return _$updateTypeAsyncAction.run(() => super.updateType(uid, type));
  }

  late final _$getUserAccountAsyncAction =
      AsyncAction('UserStoreBase.getUserAccount', context: context);

  @override
  Future<void> getUserAccount(String uid) {
    return _$getUserAccountAsyncAction.run(() => super.getUserAccount(uid));
  }

  late final _$deleteUserAsyncAction =
      AsyncAction('UserStoreBase.deleteUser', context: context);

  @override
  Future<void> deleteUser() {
    return _$deleteUserAsyncAction.run(() => super.deleteUser());
  }

  late final _$UserStoreBaseActionController =
      ActionController(name: 'UserStoreBase', context: context);

  @override
  void cleanData() {
    final _$actionInfo = _$UserStoreBaseActionController.startAction(
        name: 'UserStoreBase.cleanData');
    try {
      return super.cleanData();
    } finally {
      _$UserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username},
userType: ${userType},
userList: ${userList},
supportUsers: ${supportUsers},
developerUsers: ${developerUsers}
    ''';
  }
}
