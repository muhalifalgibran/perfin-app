import 'package:flutter/material.dart';
import 'package:perfin_app/features/auth/presentation/pages/registration_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40),
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
              decoration: const InputDecoration(
                hintText: 'email',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              autofocus: false,
              decoration: const InputDecoration(
                hintText: 'password',
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              child: ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green),
                ),
                onPressed: () {},
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
                        builder: (context) => const RegistrationPage(),
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
    );
  }
}
