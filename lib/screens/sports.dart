import 'package:flutter/material.dart';
import 'package:spree_portal/screens/sports_screen.dart';

class Sports extends StatelessWidget {
  Sports({super.key});
  final List<String> sports = [
    'Table-tennis',
    'Snooker',
    'Badminton',
    'Squash',
    'Kabbadi',
    'Volleyball',
    'Football',
    'Tennis',
    'Basketball',
    'Athletics',
    'Chess',
    'Carrom',
    'Powerlifting',
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sports.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(sports[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      SportDetailsScreen(sport: sports[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
