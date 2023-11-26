import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/features/auth/presentation/cubit/login_cubit.dart';
import 'package:perfin_app/features/auth/presentation/pages/registration_page.dart';
import 'package:perfin_app/features/home/presentation/pages/home_page.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _cubit = getIt<LoginCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: BlocListener<LoginCubit, LoginState>(
          bloc: _cubit,
          listener: (context, state) {
            if (state.isSuccess) {
              EasyLoading.dismiss();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            } else if (state.isFailed) {
              EasyLoading.showError(
                'invalid email or password',
                duration: const Duration(milliseconds: 1500),
              );
            } else if (state.isLoading) {
              EasyLoading.show(status: 'wait...');
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'PerFin.',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const Text(
                  'Your simple personal finance management app',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 56),
                TextFormField(
                  autofocus: false,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter some text';
                    } else if (!isValidEmail(value)) {
                      return 'please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  autofocus: false,
                  controller: _passwordCtrl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter some text';
                    } else if (value.length < 6) {
                      return 'enter minimum 6 character';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.green),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _cubit.doLogin(_emailCtrl.text, _passwordCtrl.text);
                      }
                    },
                    child: const Text(
                      'login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('don\'t have an account yet? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(),
                          ),
                        );
                      },
                      child: const Text(
                        'register!',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Simple email validation using a regular expression
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
