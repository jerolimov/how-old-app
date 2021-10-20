import 'package:flutter/material.dart';
import 'package:howold/data.dart';

import 'package:duration/duration.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: const Text("How old are you?"),
      ),
      body: ListView.builder(
        itemCount: kids.length,
        itemBuilder: (context, index) {
          final kid = kids[index];
          String age = prettyDuration(now.difference(kid.birth), tersity: DurationTersity.day);
          return ListTile(
            title: Text(kid.name),
            subtitle: Text(age),
          );
        },
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
