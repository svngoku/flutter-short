import 'package:flutter/material.dart';
import 'random_words.dart';

void main() => runApp(MyApp());
// Home Page 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final : like a const 
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink[800]),
      home: RandomWords());
  }
}