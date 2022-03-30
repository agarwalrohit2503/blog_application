import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatelessWidget {
  const LoginDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController pwdController = TextEditingController();
    final errNotifier = ValueNotifier('');
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Login"),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: "Email"),
            ),
            TextField(
              controller: pwdController,
              decoration: const InputDecoration(hintText: "Password"),
              obscureText: true,
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  final pwd = pwdController.text.trim();
                  if (email.isEmpty || pwd.isEmpty) {
                    errNotifier.value = "Please enter the email and password";
                  }
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(email: email, password: pwd)
                      .then((value) {
                    Navigator.pop(context);
                  }).catchError((error) {
                    if (error is FirebaseAuthException) {
                      errNotifier.value = error.message ?? "";
                    }
                  });
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ValueListenableBuilder(
              valueListenable: errNotifier,
              builder: (BuildContext context, String value, Widget? child) {
                return value.isEmpty
                    ? const SizedBox()
                    : Provider<String>.value(
                        value: value,
                        child: const TextError(),
                      );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextError extends StatelessWidget {
  const TextError({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<String>(context);
    return Container(
      width: double.infinity,
      color: Colors.red,
      padding: const EdgeInsets.all(10),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
