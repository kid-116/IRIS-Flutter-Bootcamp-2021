import 'package:flutter/material.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:hive/hive.dart';
import 'dart:io';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int numContacts = Hive.box('contacts').length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: numContacts,
        itemBuilder: (BuildContext context, int index) {
          final dynamic contactBox = Hive.box('contacts');
          Contact contact = contactBox.getAt(index) as Contact;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                        radius: 30,
                        backgroundImage: contact.image == null
                            ? AssetImage('assets/default-avatar.jpg')
                            : FileImage(File(contact.image))
                    ),
                    SizedBox(width: 50),
                    Text(
                      contact.name,
                      style: TextStyle(
                        letterSpacing: 2,
                        fontFamily: 'YuseiMagic',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  await Navigator.pushNamed(context, '/show', arguments: index);
                  setState(() {
                    numContacts = Hive.box('contacts').length;
                  });
                },
              ),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/update', arguments: {
            'action': 'New',
            'contactIndex': null,
          });
          setState(() {
            numContacts = Hive.box('contacts').length;
          });
        },
        tooltip: 'New Contact',
        child: Icon(Icons.add),
      ),
    );
  }
}
