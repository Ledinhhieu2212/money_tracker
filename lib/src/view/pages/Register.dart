import 'package:flutter/material.dart';
import 'package:money_tracker/model/Styles/images.dart';
import 'package:money_tracker/src/view/pages/Login.dart';
import 'package:money_tracker/src/view/widgets/button.dart';
import 'package:money_tracker/src/view/widgets/navigation_menu.dart';
import 'package:money_tracker/src/view/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _re_passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                SizedBox(height: 240, child: Center(child: imageBase().Logo)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: _usernameController,
              label: "Username",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: _passwordController,
              label: "Password",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: _re_passwordController,
              label: "Repeat password",
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFieldCustom(
              controller: _phoneController,
              label: "Your phone",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ButtonCustom(
              onPressed: () {},
              title: "Sign up",
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text("Login on account"),
          ),
        ],
      )),
    );
  }
}
