import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medisure/authentication/login.dart';
import 'package:medisure/components/auth_text_field.dart';
import 'package:medisure/components/dialog_card.dart';
import 'package:medisure/main.dart';
import 'package:medisure/services/firebase_services.dart';
import 'package:medisure/services/reusable_functions.dart';

import '../components/circular_auth_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 75.0, left: 20.0),
              child: Text(
                "Create",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 15.0),
              child: Text(
                "Account",
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AuthFormTextField(hintText: "Username", isPassword: false, textEditingController: usernameController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: AuthFormTextField(hintText: "Email", isPassword: false, textEditingController: emailController),
                  ),
                  AuthFormTextField(hintText: "Password", isPassword: true, textEditingController: passwordController),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Sign Up", style: TextStyle(fontSize: 35.0)),
                        CircularAuthButton(
                          onTap: () async {
                            FormState? formState = _formKey.currentState;
                            if (formState!.validate()) {
                              try {
                                Services().signUpWithEmailAndPassword(emailController.text, passwordController.text).then(
                                      (value) => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Master(),
                                        ),
                                      ),
                                    );
                              } on FirebaseException catch (error) {
                                ReusableFunctions.logError(error.message);
                                showDialog(
                                  context: context,
                                  builder: (context) => CustomDialogBox(title: "Error", descriptions: error.message.toString(), text: "Close"),
                                );
                              }
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => const CustomDialogBox(title: "Form Incomplete", descriptions: "Please fill out the form before signing up", text: "Okay"),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                ),
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
