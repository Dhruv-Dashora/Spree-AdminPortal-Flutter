// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// class Scoreboard extends StatefulWidget {
//   final String team1Name;
//   final String team2Name;

//   Scoreboard({required this.team1Name, required this.team2Name});

//   @override
//   State<Scoreboard> createState() => _ScoreboardState();
// }

// class _ScoreboardState extends State<Scoreboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
        
//         title: Text('Scorecard'),
      
        
        
//       ),
//       body: ScoreboardPage(team1Name: widget.team1Name, team2Name: widget.team2Name),
//     );
//   }
// }

// class ScoreboardPage extends StatefulWidget {
//   final String team1Name;
//   final String team2Name;

//   ScoreboardPage({required this.team1Name, required this.team2Name});

//   @override
//   _ScoreboardPageState createState() => _ScoreboardPageState();
// }

// class _ScoreboardPageState extends State<ScoreboardPage> {
//   final DatabaseReference _scoresRef =
//       FirebaseDatabase.instance.ref().child('scores');

//   int _team1Score = 0;
//   int _team2Score = 0;

//   void _incrementScore(int team) {
//     setState(() {
//       if (team == 1) {
//         _team1Score++;
//         _scoresRef.child('team1').set(_team1Score);
//       } else {
//         _team2Score++;
//         _scoresRef.child('team2').set(_team2Score);
//       }
//     });
//   }

//   void _decrementScore(int team) {
//     setState(() {
//       if (team == 1 && _team1Score > 0) {
//         _team1Score--;
//         _scoresRef.child('team1').set(_team1Score);
//       } else if (team == 2 && _team2Score > 0) {
//         _team2Score--;
//         _scoresRef.child('team2').set(_team2Score);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       body: Center(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             _buildScoreCard(1, _team1Score),
//             _buildScoreCard(2, _team2Score),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildScoreCard(int team, int score) {
//     String teamName = team == 1 ? widget.team1Name : widget.team2Name;

//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               teamName,
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             IconButton(
//               icon: const Icon(Icons.arrow_upward),
//               onPressed: () => _incrementScore(team),
//             ),
//             Text(
//               '$score',
//               style: const TextStyle(fontSize: 24),
//             ),
//             IconButton(
//               icon: const Icon(Icons.arrow_downward),
//               onPressed: () => _decrementScore(team),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// class Scoreboard extends StatefulWidget {
//   final String gameName;

//   Scoreboard({required this.gameName});

//   @override
//   State<Scoreboard> createState() => _ScoreboardState();
// }

// class _ScoreboardState extends State<Scoreboard> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Scorecard'),
//       ),
//       body: ScoreboardPage(gameName: widget.gameName),
//     );
//   }
// }

// class ScoreboardPage extends StatefulWidget {
//   final String gameName;

//   ScoreboardPage({required this.gameName});

//   @override
//   _ScoreboardPageState createState() => _ScoreboardPageState();
// }

// class _ScoreboardPageState extends State<ScoreboardPage> {
//   late DatabaseReference _gameRef;

//   @override
//   void initState() {
//     super.initState();
//     _gameRef = FirebaseDatabase.instance.ref().child('games').child(widget.gameName);
//   }

//   void _incrementScore(String team, int currentScore) {
//     _gameRef.child(team).child('score').set(currentScore + 1);
//   }

//   void _decrementScore(String team, int currentScore) {
//     if (currentScore > 0) {
//       _gameRef.child(team).child('score').set(currentScore - 1);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder(
//           stream: _gameRef.onValue,
//           builder: (context, snapshot) {
//             if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
//               Map<dynamic, dynamic>? matches = (snapshot.data!.snapshot.value as Map<dynamic, dynamic>?) ?? {};

//               return ListView.builder(
//                 itemCount: matches.length,
//                 itemBuilder: (context, index) {
//                   String matchKey = matches.keys.toList()[index];
//                   Map<dynamic, dynamic> match = matches[matchKey];
//                   String team1Name = match['team1']['name'];
//                   int team1Score = match['team1']['score'];
//                   String team2Name = match['team2']['name'];
//                   int team2Score = match['team2']['score'];
//                   return MatchCard(
//                     matchKey: matchKey,
//                     team1Name: team1Name,
//                     team1Score: team1Score,
//                     team2Name: team2Name,
//                     team2Score: team2Score,
//                     onIncrement: _incrementScore,
//                     onDecrement: _decrementScore,
//                   );
//                 },
//               );
//             } else {
//               return CircularProgressIndicator();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class MatchCard extends StatelessWidget {
//   final String matchKey;
//   final String team1Name;
//   final int team1Score;
//   final String team2Name;
//   final int team2Score;
//   final Function(String, int) onIncrement;
//   final Function(String, int) onDecrement;

//   MatchCard({
//     required this.matchKey,
//     required this.team1Name,
//     required this.team1Score,
//     required this.team2Name,
//     required this.team2Score,
//     required this.onIncrement,
//     required this.onDecrement,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               '$team1Name vs $team2Name',
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildScoreButton(team1Name, team1Score, onIncrement),
//                 Text(
//                   '$team1Score : $team2Score',
//                   style: const TextStyle(fontSize: 24),
//                 ),
//                 _buildScoreButton(team2Name, team2Score, onIncrement),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildScoreButton(String teamName, int score, Function(String, int) onPressed) {
//     return Column(
//       children: [
//         Text(
//           teamName,
//           style: const TextStyle(fontSize: 16),
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_upward),
//           onPressed: () => onPressed(teamName.toLowerCase(), score),
//         ),
//         Text(
//           '$score',
//           style: const TextStyle(fontSize: 18),
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_downward),
//           onPressed: () => onDecrement(teamName.toLowerCase(), score),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Scoreboard extends StatefulWidget {
  final String sportName;

  Scoreboard({required this.sportName});

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
      body: ScoreboardPage(sportName: widget.sportName),
    );
  }
}

class ScoreboardPage extends StatefulWidget {
  final String sportName;

  ScoreboardPage({required this.sportName});

  @override
  _ScoreboardPageState createState() => _ScoreboardPageState();
}

class _ScoreboardPageState extends State<ScoreboardPage> {
  late DatabaseReference _sportRef;

  @override
  void initState() {
    super.initState();
    _sportRef = FirebaseDatabase.instance.ref().child('sports').child(widget.sportName);
  }

  void _incrementScore(String gameName, String team, int currentScore) {
    _sportRef.child(gameName).child(team).child('score').set(currentScore + 1);
  }

  void _decrementScore(String gameName, String team, int currentScore) {
    if (currentScore > 0) {
      _sportRef.child(gameName).child(team).child('score').set(currentScore - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: _sportRef.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data?.snapshot.value != null) {
              Map<dynamic, dynamic>? games = (snapshot.data!.snapshot.value as Map<dynamic, dynamic>?) ?? {};

              return ListView.builder(
                itemCount: games.length,
                itemBuilder: (context, index) {
                  String gameKey = games.keys.toList()[index];
                  Map<dynamic, dynamic> game = games[gameKey];
                  String team1Name = game['team1']['name'];
                  int team1Score = game['team1']['score'];
                  String team2Name = game['team2']['name'];
                  int team2Score = game['team2']['score'];
                  return GameCard(
                    gameKey: gameKey,
                    team1Name: team1Name,
                    team1Score: team1Score,
                    team2Name: team2Name,
                    team2Score: team2Score,
                    onIncrement: _incrementScore,
                    onDecrement: _decrementScore,
                  );
                },
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

class GameCard extends StatelessWidget {
  final String gameKey;
  final String team1Name;
  final int team1Score;
  final String team2Name;
  final int team2Score;
  final Function(String, String, int) onIncrement;
  final Function(String, String, int) onDecrement;

  GameCard({
    required this.gameKey,
    required this.team1Name,
    required this.team1Score,
    required this.team2Name,
    required this.team2Score,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Game: $gameKey',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildScoreButton(team1Name, team1Score, onIncrement),
                Text(
                  '$team1Score : $team2Score',
                  style: const TextStyle(fontSize: 24),
                ),
                _buildScoreButton(team2Name, team2Score, onIncrement),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreButton(String teamName, int score, Function(String, String, int) onPressed) {
    return Column(
      children: [
        Text(
          teamName,
          style: const TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_upward),
          onPressed: () => onPressed(gameKey, teamName.toLowerCase(), score),
        ),
        Text(
          '$score',
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_downward),
          onPressed: () => onDecrement(gameKey, teamName.toLowerCase(), score),
        ),
      ],
    );
  }
}

