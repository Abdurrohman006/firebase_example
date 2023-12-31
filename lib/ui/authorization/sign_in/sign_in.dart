import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/authorization/sign_up/sign_up.dart';
import 'package:firebase_example/ui/home/home_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpPage(),
                    ));
              },
              icon: const Icon(Icons.supervised_user_circle))
        ],
        title: const Text("SignIn Page"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text("Shaxsiy hisobingizni kiriting"),
            const SizedBox(height: 32),
            TextField(
              controller: email,
              decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("Email")),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: password,
              decoration: const InputDecoration(border: OutlineInputBorder(), label: Text("password")),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              color: Colors.blueAccent,
              onPressed: () async {
                try {
                  UserCredential user =
                      await auth.signInWithEmailAndPassword(email: email.text, password: password.text);
                  // ignore: use_build_context_synchronously
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ),
                      (route) => false);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString()),
                    ),
                  );
                }
                // print("_____________________ $user");
              },
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
