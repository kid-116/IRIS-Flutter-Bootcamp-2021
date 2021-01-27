import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:contacts_app/models/contact.dart';
import 'dart:io';

Text fieldName(String text) {
  return Text(
    text,
    style: fieldNameStyle(),
  );
}

TextStyle fieldNameStyle() {
  return TextStyle(
    color: Colors.blue,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
  );
}

Text fieldVal(String text) {
  return Text(
    text,
    style: fieldValStyle(),
  );
}

TextStyle fieldValStyle() {
  return TextStyle(
    color: Colors.black,
    fontSize: 28,
    fontWeight: FontWeight.bold,
  );
}

class Show extends StatefulWidget {
  @override
  _ShowState createState() => _ShowState();
}

class _ShowState extends State<Show> {
  @override
  Widget build(BuildContext context) {
    final index = ModalRoute.of(context).settings.arguments;
    Contact contact = Hive.box('contacts').getAt(index) as Contact;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Contact'),
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(26),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: contact.image == null
                                ? AssetImage('assets/default-avatar.jpg')
                                : FileImage(File(contact.image))
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      fieldName('NAME'),
                      fieldVal(contact.name),
                      SizedBox(height: 20),
                      fieldName('MOBILE'),
                      fieldVal(contact.mobile),
                      SizedBox(height: 20),
                      fieldName('EMAIL'),
                      fieldVal(contact.email),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            tooltip: 'Edit',
                            icon: Icon(Icons.edit),
                            onPressed: () async {
                              await Navigator.pushNamed(context, '/update', arguments: {
                                'action': 'Update',
                                'index': index,
                              });
                              setState(() {
                                contact = Hive.box('contacts').getAt(index) as Contact;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(140, 0, 140, 0),
            child: Center(
              child: ListTile(
                tileColor: Colors.redAccent,
                title: Text('Delete'),
                trailing: Icon(
                  Icons.delete,
                ),
                onTap: () {
                  Hive.box('contacts').deleteAt(index);
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
