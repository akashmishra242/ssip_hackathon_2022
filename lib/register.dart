import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
              child: Text("Sign In")),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
              child: Text("Log In"))
        ],
      ),
    );
  }
}
