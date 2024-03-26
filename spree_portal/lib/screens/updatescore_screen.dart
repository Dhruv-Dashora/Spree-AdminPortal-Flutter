import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MatchInfoScreen extends StatefulWidget {
  final String sport;
  final String gameTitle;

  MatchInfoScreen({required this.sport, required this.gameTitle});

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
  late DatabaseReference _sportRef;
  String team1 = "";
  String team2 = "";
  String score1 = "";
  String score2 = "";
  String progress = "";

  @override
  void initState() {
    super.initState();
    _sportRef = FirebaseDatabase.instance
        .ref()
        .child('sports/${widget.sport}/${widget.gameTitle}');
    _fetchGameData();
  }

  void _incrementScore(String lr, String currentScore) async {
    int t = int.parse(currentScore);
    t++;
    await _sportRef.update({
      "score$lr": t.toString(),
    });
  }

  void _decrementScore(String lr, String currentScore) async {
    int t = int.parse(currentScore);
    t--;
    await _sportRef.update({
      "score$lr": t.toString(),
    });
  }

  void _updateProgress(String newProgress) async {
    await _sportRef.update({
      "progress": newProgress,
    });
  }

  void _fetchGameData() {
    _sportRef.onValue.listen((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> gameData =
            event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          team1 = gameData['team1'] ?? '';
          team2 = gameData['team2'] ?? '';
          score1 = gameData['score1'] ?? '';
          score2 = gameData['score2'] ?? '';
          progress = gameData['progress'] ?? '';
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameTitle),
      ),
      body: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Team 1:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(team1),
                  SizedBox(height: 10),
                  Text(
                    'Score:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$score1'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _decrementScore("1", score1),
                        child: Icon(Icons.remove),
                      ),
                      ElevatedButton(
                        onPressed: () => _incrementScore("1", score1),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Team 2:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(team2),
                  SizedBox(height: 10),
                  Text(
                    'Score:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('$score2'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () => _decrementScore("2", score2),
                        child: Icon(Icons.remove),
                      ),
                      ElevatedButton(
                        onPressed: () => _incrementScore("2", score2),
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => _updateProgress('past'),
              child: Text('Past'),
            ),
            ElevatedButton(
              onPressed: () => _updateProgress('live'),
              child: Text('Live'),
            ),
            ElevatedButton(
              onPressed: () => _updateProgress('upcoming'),
              child: Text('Upcoming'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('Current Progress: $progress'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
