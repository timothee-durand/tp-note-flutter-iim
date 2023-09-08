import 'package:flutter/material.dart';

import '../models/user.dart';
import '../utils/styles.dart';

class UserForm extends StatelessWidget {
  final _formkey = GlobalKey<FormState>();

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final String buttonLabel;
  final Function(String userName, String password) onSubmit;

  UserForm({super.key, this.buttonLabel = 'Login', required this.onSubmit, User? initialUser}) {
    if(initialUser != null) {
      userNameController.text = initialUser.name;
      passwordController.text = initialUser.userPassword;
    }
  }

  void submit() {
    if (_formkey.currentState != null && _formkey.currentState!.validate()) {
      onSubmit(userNameController.text, passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length < 5) {
                return "Your username should be more than 5 characters";
              } else if (value != null && value.isEmpty) {
                return "Please type your username";
              }
              return null;
            },
            controller: userNameController,
            decoration: const InputDecoration(
                label: Text("Username"),
                hintText: 'johndoe24',
                border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 24,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length < 5) {
                return "Your password should be more than 5 characters";
              } else if (value != null && value.isEmpty) {
                return "Your password should not be empty";
              }
              return null;
            },
            obscureText: true,
            decoration: const InputDecoration(
                label: Text("Password"),
                hintText: '123456',
                border: OutlineInputBorder()),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: submit,
            style: bigBtn,
            child: Text(buttonLabel),
          ),
        ],
      ),
    );
  }
}
