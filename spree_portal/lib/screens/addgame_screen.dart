import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AddGameScreen extends StatefulWidget {
  final String sport;

  AddGameScreen({required this.sport});

  @override
  _AddGameScreenState createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  final TextEditingController _gameTitleController = TextEditingController();
  final TextEditingController _team1Controller = TextEditingController();
  final TextEditingController _team2Controller = TextEditingController();
  final TextEditingController _score1Controller = TextEditingController();
  final TextEditingController _score2Controller = TextEditingController();

  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Game'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Game Title'),
            TextField(controller: _gameTitleController),
            SizedBox(height: 20.0),
            Text('Team 1'),
            TextField(controller: _team1Controller),
            SizedBox(height: 20.0),
            Text('Team 2'),
            TextField(controller: _team2Controller),
            SizedBox(height: 20.0),
            Text('Score 1'),
            TextField(controller: _score1Controller),
            SizedBox(height: 20.0),
            Text('Score 2'),
            TextField(controller: _score2Controller),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Create JSON format for the input
                Map<String, dynamic> gameData = {
                  'game_title': _gameTitleController.text,
                  'team1': _team1Controller.text,
                  'team2': _team2Controller.text,
                  'score1': _score1Controller.text,
                  'score2': _score2Controller.text,
                };

                // Get a reference to the sport's folder
                DatabaseReference sportRef =
                    _database.child('sports/${widget.sport}/${_gameTitleController.text}');

                // Push the game data under the sport's folder
                sportRef.set(gameData);

                // Clear text fields after adding the game
                _gameTitleController.clear();
                _team1Controller.clear();
                _team2Controller.clear();
                _score1Controller.clear();
                _score2Controller.clear();

                // Go back to previous screen
                Navigator.pop(context);
              },
              child: Text('Add Game'),
            ),
          ],
        ),
      ),
    );
  }
}
