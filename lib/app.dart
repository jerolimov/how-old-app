import 'package:flutter/material.dart';
import 'package:howold/home_page.dart';

class HowOldApp extends StatelessWidget {
  const HowOldApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}
