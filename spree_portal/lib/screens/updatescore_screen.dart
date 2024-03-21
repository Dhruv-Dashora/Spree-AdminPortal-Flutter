import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MatchInfoScreen extends StatefulWidget {
  final String sport;
  final String gameTitle;
  //final Map<String, dynamic> matchInfo;

  MatchInfoScreen({required this.sport, required this.gameTitle});

  @override
  State<MatchInfoScreen> createState() => _MatchInfoScreenState();
}

class _MatchInfoScreenState extends State<MatchInfoScreen> {
//
  late DatabaseReference _sportRef;
   String team1 = "";
   String team2 ="";
   String score1 = "";
   String score2 = "";

  @override
  void initState() {
    super.initState();
    _sportRef = FirebaseDatabase.instance.ref().child('sports/${widget.sport}/${widget.gameTitle}');
    _fetchGameData();
  }
  void _incrementScore (String lr, String currentScore) async {
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

  void _fetchGameData() async {
    // final ref = FirebaseDatabase.instance.ref();
    // final snapshot = await ref.child('sports/${widget.sport}/${widget.gameTitle}').get();
    // if (snapshot.exists) {
    //   //team1 = snapshot.value[team1];
    //  print(snapshot.value);
    //   } else {
    // print('No data available.');
    //   }
    _sportRef.onValue.listen((DatabaseEvent event) {
      
      // Map<String, dynamic>? gameData = snapshot.value;
      // if (gameData != null) {
      //   setState(() {
      //     team1 = gameData['team1'] ?? '';
      //     team2 = gameData['team2'] ?? '';
      //     score1 = gameData['score1'] ?? '';
      //     score2 = gameData['score2'] ?? '';
      //   });
      // }


      if (event.snapshot.value != null) {
      
      Map<dynamic, dynamic> gameData = event.snapshot.value as Map<dynamic, dynamic>;
      
      setState(() {
          team1 = gameData['team1'] ?? '';
          team2 = gameData['team2'] ?? '';
          score1 = gameData['score1'] ?? '';
          score2 = gameData['score2'] ?? '';
      });
    }
    });
    // .catchError((error) {
    //   print('Error fetching game data: $error');
    // });
  }

//

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text(widget.gameTitle),
  //     ),
  //     body: Padding(
  //       padding: EdgeInsets.all(20.0),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Game Title:',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           Text(widget.gameTitle),
  //           SizedBox(height: 10),
  //           Text(
  //             'Team 1:',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           Text(team1),
  //           SizedBox(height: 10),
  //           Text(
  //             'Team 2:',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           Text(team2),
  //           SizedBox(height: 10),
  //           Text(
  //             'Score 1:',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           Text('${score1}'),
  //           SizedBox(height: 10),
  //           Text(
  //             'Score 2:',
  //             style: TextStyle(fontWeight: FontWeight.bold),
  //           ),
  //           Text('${score2}'),
  //         ],
  //       ),
  //     ),
  //   );
  // }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameTitle),
      ),
      body: Row(
        children: [
          Expanded(
            child: _buildTeamColumn(
              teamName: team1,
              score: score1,
              onIncrement: () => _incrementScore("1",score1),
              onDecrement: () =>_decrementScore("1",score1),
            ),
          ),
          Expanded(
            child: _buildTeamColumn(
              teamName: team2,
              score: score2,
              onIncrement: () => _incrementScore("2",score2),
              onDecrement: () => _decrementScore("2",score1),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamColumn({
    required String teamName,
    required String score,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Team:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(teamName),
          SizedBox(height: 10),
          Text(
            'Score:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('$score'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: onDecrement,
                child: Icon(Icons.remove),
              ),
              ElevatedButton(
                onPressed: onIncrement,
                child: Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

