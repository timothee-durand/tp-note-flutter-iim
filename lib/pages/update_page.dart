import 'package:flutter/material.dart';

import 'package:tp_note_flutter/utils/styles.dart';

import '../models/user.dart';
import '../repo/user_repository.dart';
import '../widgets/link.dart';
import '../widgets/user_form.dart';

class UpdatePage extends StatefulWidget {
  final int userId;

  const UpdatePage({super.key, required this.userId});

  @override
  State<StatefulWidget> createState() {
    return UpdatePageState();
  }
}

class UpdatePageState extends State<UpdatePage> {
  late UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _userRepository = UserRepository();
  }

  Future<User> getUser() async {
    final result = await _userRepository.getUser(widget.userId);
    if (result == null) throw Exception("User not found");
    return result;
  }

  Future<void> updateUser(int id, String userName, String password) async {
    await _userRepository
        .updateUser(User(id: id, name: userName, userPassword: password));
    final updatedUser = await _userRepository.getUser(id);
    if (!context.mounted) return;
    if(updatedUser == null)  {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error"), backgroundColor: Colors.red));
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("User updated : ${updatedUser!.toString()}"), backgroundColor: Colors.green));
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data as User;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: loadedBody(user),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }

  List<Widget> loadedBody(User user) {
    return [
      Text("You can now update your user", style: titleStyle),
      Text("Your user id : ${user.id}", style: subtitleStyle,),
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(20),
        child: UserForm(
          buttonLabel: 'Update',
          onSubmit: (userName, password) => updateUser(user.id as int, userName, password),
          initialUser: user,
        ),
      ),
    ];
  }
}
