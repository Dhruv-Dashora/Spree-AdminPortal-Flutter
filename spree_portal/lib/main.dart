import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:spree_portal/firebase_options.dart';
import 'package:spree_portal/screens/home.dart';
import 'package:spree_portal/screens/login.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Login(),
  ));
}

