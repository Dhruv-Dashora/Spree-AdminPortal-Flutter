import 'package:flutter/material.dart';

class Portal extends StatefulWidget {
  const Portal({Key? key}) : super(key: key);

  @override
  State<Portal> createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  
  List<String> items = ['Table-Tennis', 'Snooker','Badminton','Squash','Kabbadi','Volleyball','Football','Tennis','Basketball','UFC'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Scorecard',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0,20.0,8.0,8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                    ),
                    child: ListTile(
                      title: Text(items[index]),
                    ),
                  ),
                ),
                SizedBox(height: 10), 
              ],
            );
          },
        ),
      ),
    );
  }
}
