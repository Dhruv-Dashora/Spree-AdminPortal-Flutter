import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:spree_portal/components/matchestemp.dart';
import 'package:spree_portal/components/scoretemplate.dart';

class Portal extends StatefulWidget {
  const Portal({Key? key}) : super(key: key);

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  List<String> sports = [
    'Table-Tennis',
    'Snooker',
    'Badminton',
    'Squash',
    'Kabbadi',
    'Volleyball',
    'Football',
    'Tennis',
    'Basketball',
    'UFC'
  ];

  void sendSportsToFirebase() {
    _database.child('sports').set(sports);
  }

  @override
  Widget build(BuildContext context) {
    sendSportsToFirebase();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Scorecard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: sports.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                  child: GestureDetector(
                    onTap: () {
                      String sportName = sports[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Matches(sportName: sportName,),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: ListTile(
                        title: Text(sports[index]),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
  }
}
