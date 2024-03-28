import 'package:spree_portal/services/oauth.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SendNotif {
  static Future<http.Response> send(String title, String body) async {
    try {
      String oAuthToken = await OAuth.refreshToken();
      debugPrint(oAuthToken);
      final res = await http.post(
          Uri.parse(
              'https://fcm.googleapis.com/v1/projects/spree-bpgc/messages:send'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $oAuthToken'
          },
          body: jsonEncode({
            "message": {
              "topic": "new",
              "notification": {"title": title, "body": body}
            }
          }));
      if (res.statusCode == 200) {
        debugPrint('Notification sent successfully!');
      } else {
        debugPrint(res.body);
      }
      return res;
    } on Exception catch (_) {
      throw Exception('Notification Failed');
    }
  }
}
