import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:tp_note_flutter/models/user.dart';
import 'package:tp_note_flutter/repo/user_repository.dart';
import 'package:tp_note_flutter/utils/styles.dart';

import '../utils/user_id.dart';
import '../widgets/link.dart';
import '../widgets/page_header.dart';
import '../widgets/user_form.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  late UserRepository _userRepository;
  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
  }

  Future<void> registerUser(String userName, String password)  async {
    await _userRepository.insertUser(User(name: userName, userPassword: password, userId: await getNextUserId()));
    print(await _userRepository.getUserList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const PageHeader(
          title: "Let's create your account.",
          subtitle: "Welcome !",
          imagePath: 'assets/images/register.png',
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: UserForm(
            buttonLabel: 'Register',
            onSubmit: registerUser,
          ),
        ),
        link(context, 'Already registered ?', '/login')
      ]),
    );
  }
}