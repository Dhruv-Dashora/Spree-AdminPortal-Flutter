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

  String team1 = '';
  String team2 = '';

  @override
  void initState() {
    super.initState();
    _fetchMatches();
  }

  Future<void> _fetchMatches() async {
   try {
  DataSnapshot snapshot = (await _database.child(widget.sportName).once()) as DataSnapshot;
  if (snapshot.value != null) {
    Map<dynamic, dynamic>? matches = snapshot.value as Map<dynamic, dynamic>?;

    if (matches != null) {
      matches.forEach((key, value) {
        String team1 = value['team1'];
        String team2 = value['team2'];
        _matchCards.add(_buildMatchCard(team1, team2));
      });
      setState(() {});
    }
  }
} catch (e) {
  print('Error fetching matches: $e');
}

  }

  Widget _buildMatchCard(String team1, String team2) {
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddMatchCard() {
    final TextEditingController team1controller = TextEditingController();
    final TextEditingController team2controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              TextFormField(
                controller: team1controller,
                decoration: const InputDecoration(hintText: 'Enter Team 1'),
                onChanged: (value) {
                  setState(() {
                    team1 = value;
                  });
                },
              ),
              TextFormField(
                controller: team2controller,
                decoration: const InputDecoration(hintText: 'Enter Team 2'),
                onChanged: (value) {
                  setState(() {
                    team2 = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        int index = _matchCards.length - 1;
                        _matchCards.removeAt(index);
                      });
                    },
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      _database.child(widget.sportName).push().set({
                        'team1': team1controller.text,
                        'team2': team2controller.text,
                      });
                     
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Scoreboard(team1Name: team1controller.text, team2Name: team2controller.text),
                        ),
                      );
                    },
                    child: const Text('Scoreboard'),
                  ),
                ],
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
          setState(() {
            _matchCards.add(_buildAddMatchCard());
          });
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
