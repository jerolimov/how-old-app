import 'package:flutter/material.dart';
import 'package:howold/data.dart';

import 'package:duration/duration.dart';

enum Display {
  ByName,
  ByBirth,
  ByNextBirthday,
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Display display = Display.ByName;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    var orderedKids = kids;
    if (display == Display.ByName) {
      orderedKids.sort((kid1, kid2) => kid1.name.compareTo(kid2.name));
    } else if (display == Display.ByBirth) {
      orderedKids.sort((kid1, kid2) => kid1.birth.compareTo(kid2.birth));
    } else if (display == Display.ByNextBirthday) {
      orderedKids.sort((kid1, kid2) {
        var birthday1 = DateTime(now.year, kid1.birth.month, kid1.birth.day);
        if (birthday1.isBefore(now)) {
          birthday1 = DateTime(now.year + 1, kid1.birth.month, kid1.birth.day);
        }
        var birthday2 = DateTime(now.year, kid2.birth.month, kid2.birth.day);
        if (birthday2.isBefore(now)) {
          birthday2 = DateTime(now.year + 1, kid2.birth.month, kid2.birth.day);
        }
        return birthday1.compareTo(birthday2);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("How old are you?"),
      ),
      body: Column(
        children: [
          DropdownButton<Display>(
            value: display,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (Display? newValue) {
              setState(() {
                display = newValue!;
              });
            },
            items: [
              const DropdownMenuItem<Display>(
                value: Display.ByName,
                child: Text("By name"),
              ),
              const DropdownMenuItem<Display>(
                value: Display.ByBirth,
                child: Text("By birth"),
              ),
              const DropdownMenuItem<Display>(
                value: Display.ByNextBirthday,
                child: Text("By next birthday"),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: orderedKids.length,
              itemBuilder: (context, index) {
                final kid = orderedKids[index];

                if (display == Display.ByNextBirthday) {

                  var birthday = DateTime(now.year, kid.birth.month, kid.birth.day);
                  if (birthday.isBefore(now)) {
                    birthday = DateTime(now.year + 1, kid.birth.month, kid.birth.day);
                  }
                  // I know that this needs a formatter later...
                  var prettyDate = '${birthday.day}.${birthday.month}. ';
                  prettyDate += prettyDuration(now.difference(birthday), tersity: DurationTersity.day);

                  return ListTile(
                    title: Text(kid.name),
                    subtitle: Text(prettyDate),
                  );
                } else {
                  var age = now.difference(kid.birth);
                  String prettyAge = '';
                  if (age.inDays > 365) {
                    prettyAge = (age.inDays / 365).floor().toString() + ' years ';
                    // I know that this is not correct, but works for the moment
                    age = Duration(days: (age.inDays.toDouble() - 365.25 * (age.inDays / 365).floorToDouble()).toInt());
                  }
                  prettyAge += prettyDuration(age, tersity: DurationTersity.day);
                  return ListTile(
                    title: Text(kid.name),
                    subtitle: Text(prettyAge),
                  );
                }
              },
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {},
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
