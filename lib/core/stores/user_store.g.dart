// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserStore on UserStoreBase, Store {
  late final _$userAtom = Atom(name: 'UserStoreBase.user', context: context);

  @override
  Users? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(Users? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
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

  late final _$getUserAsyncAction =
      AsyncAction('UserStoreBase.getUser', context: context);

  @override
  Future<void> getUser(String uid) {
    return _$getUserAsyncAction.run(() => super.getUser(uid));
  }

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}
