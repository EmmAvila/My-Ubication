import 'package:flutter/material.dart';

import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = 'Login_Screen';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Ubication'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 145,
                height: 145,
                child: Image.asset(
                  'assets/icon.png',
                )),
            const LoginForm(),
            const SizedBox(
              height: 130,
            ),
            Row(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New User? '),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.blue, fontSize: 15),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
