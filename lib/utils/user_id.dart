import 'package:tp_note_flutter/repo/user_repository.dart';

Future<int> getNextUserId() async {
  final count = await UserRepository().countUsers();
  return count + 1;
}