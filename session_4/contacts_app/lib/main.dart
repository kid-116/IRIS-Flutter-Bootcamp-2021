import 'package:flutter/material.dart';
import 'package:contacts_app/pages/index.dart';
import 'package:contacts_app/pages/loading.dart';
import 'package:contacts_app/pages/show.dart';
import 'package:contacts_app/pages/update.dart';

void main() {
  runApp(ContactsApp());
}

class ContactsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Contacts',
      debugShowCheckedModeBanner: false,
      initialRoute: '/loading',
      routes: {
        '/loading': (context) => Loading(),
        '/home': (context) => Index(),
        '/show': (context) => Show(),
        '/update': (context) => Update(),
      },
    );
  }
}