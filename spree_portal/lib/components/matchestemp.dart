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
}
