import 'package:flutter/material.dart';
import 'package:money_tracker/src/model/styles/images.dart';
import 'package:money_tracker/src/view/pages/Register.dart';
import 'package:money_tracker/src/view/widgets/button.dart';
import 'package:money_tracker/src/view/widgets/navigation_menu.dart';
import 'package:money_tracker/src/view/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
                height: 240,
                child: Center(child: Image.asset(imageBase().Logo))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: _usernameController,
              label: "Username",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: _passwordController,
              label: "Password",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonCustom(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NavigationMenu()),
                );
              },
              title: "Sign in",
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RegisterScreen()),
              );
            },
            child: Text("Register on account"),
          ),
        ],
      )),
    );
  }
}
