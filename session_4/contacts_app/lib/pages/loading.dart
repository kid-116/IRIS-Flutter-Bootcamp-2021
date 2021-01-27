import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:contacts_app/models/contact.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupHive() async {
    final appDatabaseDir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDatabaseDir.path);
    Hive.registerAdapter(ContactAdapter());
    await Hive.openBox('contacts');
    Navigator.pushReplacementNamed(context, '/home');
  }
  @override
  void initState() {
    super.initState();
    setupHive();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.blue,
          size: 80.0,
        ),
      ),
    );
  }
}
