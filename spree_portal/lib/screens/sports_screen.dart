// import 'package:flutter/material.dart';
// import 'package:spree_portal/screens/addgame_screen.dart';

// class SportDetailsScreen extends StatelessWidget {
//   final String sport;

//   SportDetailsScreen({required this.sport});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(sport),
//       ),
//       body: Center(
//         child: Text('Details of $sport'),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddGameScreen(sport: sport),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:spree_portal/screens/addgame_screen.dart';

// class SportDetailsScreen extends StatefulWidget {
//   final String sport;

//   SportDetailsScreen({required this.sport});

//   @override
//   _SportDetailsScreenState createState() => _SportDetailsScreenState();
// }

// class _SportDetailsScreenState extends State<SportDetailsScreen> {
//   late DatabaseReference _sportRef;
//   List<dynamic> _gameTitles = [];

//   @override
//   void initState() {
//     super.initState();
//     _sportRef = FirebaseDatabase.instance.reference().child('sports/${widget.sport}');
//     _fetchGames();
//   }

//   void _fetchGames() {
//   _sportRef.once().then((DatabaseEvent event) {
//     if (event.snapshot.value != null) {
//       // Extract game titles
//       Map<dynamic, dynamic> games = event.snapshot.value as Map<dynamic, dynamic>;
//       List<dynamic> gameTitles = games.keys.toList();
//       setState(() {
//         _gameTitles = gameTitles;
//       });
//     }
//   }).catchError((error) {
//     print('Error fetching games: $error');
//   });
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.sport),
//       ),
//       body: _gameTitles.isEmpty
//           ? Center(child: Text('No games found.'))
//           : ListView.builder(
//               itemCount: _gameTitles.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   child: ListTile(
//                     title: Text(_gameTitles[index]),
//                     onTap: () {
//                       // Handle tapping on game card
//                     },
//                   ),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => AddGameScreen(sport: widget.sport),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:spree_portal/screens/addgame_screen.dart';
//import 'package:spree_portal/screens/match_info_screen.dart';
import 'package:spree_portal/screens/updatescore_screen.dart';

class SportDetailsScreen extends StatefulWidget {
  final String sport;

  SportDetailsScreen({required this.sport});

  @override
  _SportDetailsScreenState createState() => _SportDetailsScreenState();
}

class _SportDetailsScreenState extends State<SportDetailsScreen> {
  late DatabaseReference _sportRef;
  List<dynamic> _gameTitles = [];

  @override
  void initState() {
    super.initState();
    _sportRef = FirebaseDatabase.instance.ref().child('sports/${widget.sport}');
    _fetchGames();
  }

  void _fetchGames() {
  _sportRef.onValue.listen((DatabaseEvent event) {
    if (event.snapshot.value != null) {
      // Extract game titles
      Map<dynamic, dynamic> games = event.snapshot.value as Map<dynamic, dynamic>;
      List<dynamic> gameTitles = games.keys.toList();
      setState(() {
        _gameTitles = gameTitles;
      });
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.sport),
      ),
      body: _gameTitles.isEmpty
          ? Center(child: Text('No games found.'))
          : ListView.builder(
              itemCount: _gameTitles.length,
              itemBuilder: (context, index) {
                String gameTitle = _gameTitles[index];
                return Card(
                  child: ListTile(
                    title: Text(gameTitle),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MatchInfoScreen(
                            sport: widget.sport,
                            gameTitle: gameTitle,
                            
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddGameScreen(sport: widget.sport),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
