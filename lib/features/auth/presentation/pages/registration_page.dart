import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:perfin_app/core/di/service_locator.dart';
import 'package:perfin_app/features/auth/presentation/cubit/register_cubit.dart';

class RegistrationPage extends StatelessWidget {
  RegistrationPage({Key? key}) : super(key: key);

  final cubit = getIt<RegisterCubit>();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passwordCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.isLoading) {
              EasyLoading.show(status: 'registering...');
            } else if (state.isSuccess) {
              EasyLoading.dismiss();
              Navigator.pop(context);
            } else if (state.isFailed) {
              EasyLoading.dismiss();
              EasyLoading.showError(
                state.failure!.message!,
                duration: const Duration(milliseconds: 1500),
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'make account!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'enter your email and password',
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          cubit.register(_emailCtrl.text, _passwordCtrl.text);
                        }
                      },
                      child: const Text(
                        'register',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // simple email validation using a regular expression
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }
}
