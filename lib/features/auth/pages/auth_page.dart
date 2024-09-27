import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_project/core/stores/auth_store.dart';
import 'package:todo_list_project/core/stores/user_store.dart';
import 'package:todo_list_project/shared/themes/index.dart';
import 'package:todo_list_project/shared/widgets/show_snack_bar.dart';

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
  bool isSignupBottom = false;

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Observer(
          builder: (_) => authStore.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
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
                            color: MyColors.greenSofTec,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text(
                            "To-Do App",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 38,
                                fontWeight: FontWeight.bold,
                                color: MyColors.greenSofTec),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          TextFormField(
                            controller: email,
                            decoration: getAuthInputDecoration("e-mail"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return "Empty Field";
                              }
                              if (value.length < 5) {
                                return "This e-mail is very short";
                              }
                              if (!value.contains("@")) {
                                return "This e-mail is invalid";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: getAuthInputDecoration("password"),
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'This field is empty';
                              } else if (value.length < 8) {
                                return 'The password must have at least 8 characters';
                              }
                              return null;
                            },
                          ),
                          Visibility(
                            visible: isSignupBottom,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: getAuthInputDecoration(
                                      "Confirm password"),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'This field is empty';
                                    } else if (value.length < 8) {
                                      return 'The password must have at least 8 characters';
                                    } else if (value != password.text) {
                                      return 'This password is not the same';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                TextFormField(
                                  controller: username,
                                  decoration:
                                      getAuthInputDecoration("username"),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'This field is empty';
                                    } else if (value.length < 6) {
                                      return 'The username must be 6 letters';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (isSignupBottom) {
                                    authStore
                                        .signup(email.text, password.text)
                                        .then(
                                      (String? erro) {
                                        if (erro != null) {
                                          showErrorSnackBar(
                                              context: context, error: erro);
                                        }
                                      }
                                    );
                                      Provider.of<UserStore>(context).createUser(authStore.user!.uid, username.text,email.text, password.text);
                                  } else {
                                    authStore
                                        .signin(email.text, password.text)
                                        .then(
                                      (String? erro) {
                                        if (erro != null) {
                                          showErrorSnackBar(
                                              context: context, error: erro);
                                        }
                                      },
                                    );
                                    ;
                                  }
                                } else {
                                  showErrorSnackBar(
                                      context: context,
                                      error: "Some filled is invalid");
                                }
                              },
                              child: isSignupBottom
                                  ? const Text("Sign-up")
                                  : const Text("Sign-in")),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  isSignupBottom = !isSignupBottom;
                                });
                              },
                              child: isSignupBottom
                                  ? const Text("Have an account? Sign-in")
                                  : const Text(
                                      "You don't have an account? Sign-up")),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
