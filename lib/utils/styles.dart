import 'package:flutter/material.dart';

TextStyle titleStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
);


TextStyle subtitleStyle = const TextStyle(
  fontSize: 20,
  color: Colors.grey,
);

ButtonStyle bigBtn =  ButtonStyle(
  minimumSize: MaterialStateProperty.all(Size(200, 50)),
  textStyle: MaterialStateProperty.all(const TextStyle(fontWeight: FontWeight.bold)),
);