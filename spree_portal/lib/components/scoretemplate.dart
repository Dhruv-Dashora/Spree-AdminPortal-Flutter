import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Scoreboard extends StatefulWidget {
  final String team1Name;
  final String team2Name;

  Scoreboard({required this.team1Name, required this.team2Name});

  @override
  State<Scoreboard> createState() => _ScoreboardState();
}

class _ScoreboardState extends State<Scoreboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Scorecard'),
      
        
        
      ),
      body: ScoreboardPage(team1Name: widget.team1Name, team2Name: widget.team2Name),
    );
  }
}

class ScoreboardPage extends StatefulWidget {
  final String team1Name;
  final String team2Name;

  ScoreboardPage({required this.team1Name, required this.team2Name});

  @override
  _ScoreboardPageState createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  final DatabaseReference _scoresRef =
      FirebaseDatabase.instance.ref().child('scores');

  int _team1Score = 0;
  int _team2Score = 0;

  void _incrementScore(int team) {
    setState(() {
      if (team == 1) {
        _team1Score++;
        _scoresRef.child('team1').set(_team1Score);
      } else {
        _team2Score++;
        _scoresRef.child('team2').set(_team2Score);
      }
    });
  }

  void _decrementScore(int team) {
    setState(() {
      if (team == 1 && _team1Score > 0) {
        _team1Score--;
        _scoresRef.child('team1').set(_team1Score);
      } else if (team == 2 && _team2Score > 0) {
        _team2Score--;
        _scoresRef.child('team2').set(_team2Score);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildScoreCard(1, _team1Score),
            _buildScoreCard(2, _team2Score),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreCard(int team, int score) {
    String teamName = team == 1 ? widget.team1Name : widget.team2Name;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              teamName,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            IconButton(
              icon: const Icon(Icons.arrow_upward),
              onPressed: () => _incrementScore(team),
            ),
            Text(
              '$score',
              style: const TextStyle(fontSize: 24),
            ),
            IconButton(
              icon: const Icon(Icons.arrow_downward),
              onPressed: () => _decrementScore(team),
            ),
          ],
        ),
      ),
    );
  }
}
