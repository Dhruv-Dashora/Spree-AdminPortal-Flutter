import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:spree_portal/components/scoretemplate.dart';

class Matches extends StatefulWidget {
  final String sportName;

  const Matches({Key? key, required this.sportName}) : super(key: key);

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final List<Widget> _matchCards = [];

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
    try {
      DatabaseEvent event = await _database.child('sports').child(widget.sportName).once();
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic>? games = snapshot.value as Map<dynamic, dynamic>?;

        if (games != null) {
          games.forEach((gameKey, game) {
            String team1Name = game['team1']['name'];
            String team2Name = game['team2']['name'];
            _matchCards.add(_buildMatchCard(team1Name, team2Name, gameKey));
          });
          setState(() {});
        }
      }
    } catch (e) {
      print('Error fetching matches: $e');
    }
  }

  Widget _buildMatchCard(String team1, String team2, String gameKey) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$team1 vs $team2',
                style:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scoreboard(
                        sportName: widget.sportName,
                      ),
                    ),
                  );
                },
                child: const Text('Scoreboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.sportName),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // complete thissssss
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _matchCards,
        ),
      ),
    );
  }
}
