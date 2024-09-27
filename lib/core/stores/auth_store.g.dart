// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on AuthStoreBase, Store {
  late final _$_firebaseUserAtom =
      Atom(name: 'AuthStoreBase._firebaseUser', context: context);

  @override
  User? get _firebaseUser {
    _$_firebaseUserAtom.reportRead();
    return super._firebaseUser;
  }

  @override
  set _firebaseUser(User? value) {
    _$_firebaseUserAtom.reportWrite(value, super._firebaseUser, () {
      super._firebaseUser = value;
    });
  }

  late final _$userIsAuthAtom =
      Atom(name: 'AuthStoreBase.userIsAuth', context: context);

  @override
  bool get userIsAuth {
    _$userIsAuthAtom.reportRead();
    return super.userIsAuth;
  }

  @override
  set userIsAuth(bool value) {
    _$userIsAuthAtom.reportWrite(value, super.userIsAuth, () {
      super.userIsAuth = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AuthStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$signupAsyncAction =
      AsyncAction('AuthStoreBase.signup', context: context);

  @override
  Future<String?> signup(String email, String password) {
    return _$signupAsyncAction.run(() => super.signup(email, password));
  }

  late final _$signinAsyncAction =
      AsyncAction('AuthStoreBase.signin', context: context);

  @override
  Future<String?> signin(String email, String password) {
    return _$signinAsyncAction.run(() => super.signin(email, password));
  }

  late final _$logoutAsyncAction =
      AsyncAction('AuthStoreBase.logout', context: context);

  @override
  Future<String?> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''
userIsAuth: ${userIsAuth},
isLoading: ${isLoading}
    ''';
  }
}
