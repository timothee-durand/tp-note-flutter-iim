import 'package:flutter/cupertino.dart';

import '../utils/styles.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;

  const PageHeader({super.key, required this.title, required this.subtitle, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(title, style: titleStyle),
      const SizedBox(height: 10),
      Text(subtitle, style: subtitleStyle),
      const SizedBox(height: 20),
      Image(
        image: AssetImage(imagePath),
        height: 300,
      ),
    ]);
  }
}