import 'package:flutter/material.dart';
import 'package:tp_note_flutter/pages/update_page.dart';
import '../repo/user_repository.dart';
import '../widgets/link.dart';
import '../widgets/page_header.dart';
import '../widgets/user_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  late UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
  }

  Future<void> loginUser(String userName, String password) async {
    final user = await _userRepository.findUser(userName, password);
    if (!context.mounted) return;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User not found"), backgroundColor: Colors.red));
      return;
    }
    final userId = user.id;
    if(userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("User not found"), backgroundColor: Colors.red));
      return;
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UpdatePage(userId: userId)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const PageHeader(
          title: "Let's sign you in.",
          subtitle: "Welcome back.",
          imagePath: 'assets/images/login.png',
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: UserForm(
            onSubmit: loginUser,
          ),
        ),
        link(context, 'Create an account', '/register')
      ]),
    );
  }
}
