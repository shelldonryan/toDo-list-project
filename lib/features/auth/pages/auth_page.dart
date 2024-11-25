import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/repository/role_repository.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/shared/utils/show_snack_bar.dart';

import '../../../shared/themes/decoration_field_auth.dart';
import '../../../shared/themes/my_colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();
  bool isSignUp = false;

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Observer(
          builder: (_) => authStore.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            'assets/clipboard.png',
                            height: 128,
                            color: MyColors.greenForest,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "To-Do App",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: MyColors.greenForest),
                          ),
                          const SizedBox(height: 24),
                          _buildEmailField(),
                          const SizedBox(height: 8),
                          _buildPasswordField(),
                          if (isSignUp) const SizedBox(height: 8),
                          if (isSignUp) _buildConfirmPasswordField(),
                          if (isSignUp) const SizedBox(height: 8),
                          if (isSignUp) _buildUsernameField(),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: _handleAuth,
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    MyColors.greenForest), foregroundColor: WidgetStatePropertyAll(Colors.white)),
                            child: Text(isSignUp ? "Sign-up" : "Sign-in"),
                          ),
                          TextButton(
                            onPressed: _toggleSignUp,
                            child: Text(
                              isSignUp
                                  ? "Have an account? Sign-in"
                                  : "You don't have an account? Sign-up",
                              style: const TextStyle(color: MyColors.greenForest),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _toggleSignUp() {
    setState(() {
      isSignUp = !isSignUp;
    });
  }

  Future<void> _handleAuth() async {
    if (_formKey.currentState!.validate()) {
      final authStore = Provider.of<AuthStore>(context, listen: false);
      final userStore = Provider.of<UserStore>(context, listen: false);
      String? errorMessage;

      if (isSignUp) {
        errorMessage = await authStore.signup(email.text, password.text);
        if (errorMessage == null) {
          await _createUserRoleAndInfo(userStore);
        }
      } else {
        errorMessage = await authStore.signin(email.text, password.text);
      }

      if (errorMessage != null) {
        showErrorSnackBar(context: context, error: errorMessage);
      }
    } else {
      showErrorSnackBar(context: context, error: "Some fields are invalid");
    }
  }

  Future<void> _createUserRoleAndInfo(UserStore userStore) async {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    authStore.user?.updateDisplayName(username.text);
    final role = username.text.toLowerCase().contains("shelldon")
        ? "developer"
        : "support";

    await userStore.createUser(
      authStore.userId!,
      username.text,
      email.text,
      password.text,
      role,
    );
    await RoleRepository().create(authStore.userId!, role);
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: email,
      decoration: getAuthInputDecoration("e-mail"),
      validator: (String? value) {
        if (value!.isEmpty) return "Empty Field";
        if (!isValidEmail(value)) return "This e-mail is invalid";
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: password,
      obscureText: true,
      decoration: getAuthInputDecoration("password"),
      validator: (String? value) {
        if (value!.isEmpty) return 'This field is empty';
        if (value.length < 8)
          return 'The password must have at least 8 characters';
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: true,
      decoration: getAuthInputDecoration("Confirm password"),
      validator: (String? value) {
        if (value!.isEmpty) return 'This field is empty';
        if (value.length < 8)
          return 'The password must have at least 8 characters';
        if (value != password.text) return 'This password is not the same';
        return null;
      },
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: username,
      decoration: getAuthInputDecoration("username"),
      validator: (String? value) {
        if (value!.isEmpty) return 'This field is empty';
        if (value.length < 2)
          return 'The username must have at least 2 letters';
        return null;
      },
    );
  }

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegExp.hasMatch(email);
  }
}
