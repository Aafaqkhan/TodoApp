import 'package:flutter/material.dart';
import 'package:new_todo/AuthService.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    await AuthService()
                        .handleEmailSignUp(email, password, context);
                  },
                  child: Text('Sign Up'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String email = emailController.text;
                    String password = passwordController.text;
                    await AuthService()
                        .handleEmailSignIn(email, password, context);
                  },
                  child: Text('Sign In'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await AuthService().handleGoogleSignIn(context);
                  },
                  child: Text('Google'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
