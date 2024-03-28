import 'package:flutter/material.dart';
import 'package:spree_portal/screens/notif.dart';
import 'package:spree_portal/screens/sports.dart';
import 'package:spree_portal/screens/sports_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = [
    Sports(),
    Notif()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sports'),
      ),
      drawer: Drawer(
          backgroundColor: Color(0xFF1E1E1E),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.announcement_outlined,
                      color: Colors.white),
                  title: const Text(
                    'Update Scores',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    onItemTapped(0);
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                ListTile(
                  leading: const Icon(
                    Icons.add_alert_outlined,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'Send Notification',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                  onTap: () {
                    onItemTapped(1);
                    Navigator.pop(context);
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
              ],
            ),
          ),
        ),
      body: widgetOptions[selectedIndex]
    );
  }
}