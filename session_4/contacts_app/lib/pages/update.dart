import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class Update extends StatefulWidget {
  @override
  _UpdateState createState() => _UpdateState();
}
class _UpdateState extends State<Update> {
  bool imagePicked = false;
  Contact contact;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    final nameController = TextEditingController();
    final mobileController = TextEditingController();
    final emailController = TextEditingController();
    void setupFields() {
      nameController.text = contact.name;
      mobileController.text = contact.mobile;
      emailController.text = contact.email;
      setState(() {});
    }
    void saveFields() {
      contact.name = nameController.text;
      contact.mobile = mobileController.text;
      contact.email = emailController.text;
    }
    if(!imagePicked) {
      contact = args['index'] == null ? Contact() : Hive.box('contacts').getAt(args['index']) as Contact;
    }
    final picker = ImagePicker();
    Future pickImage() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          contact.image = pickedFile.path;
        } else {
          print('No image selected.');
        }
      });
    }
    String buttonText;
    if(args['action'] == "New") {
      buttonText = "Create";
    }
    else {
      buttonText = "Update";
    }
    setupFields();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${args['action']} Contact'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if(args['action'] == "Update") {
              contact = Hive.box('contacts').getAt(args['index']) as Contact;
              print(contact);
            }
            Navigator.pop(context);
          }
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Row(
                  children: [
                    SizedBox(width: 45),
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: contact.image == null
                          ? AssetImage('assets/default-avatar.jpg')
                          : FileImage(File(contact.image))
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_circle_up),
                      onPressed: () async {
                        imagePicked = true;
                        saveFields();
                        await pickImage();
                      }
                    ),
                    SizedBox(width: 150),
                    IconButton(
                      color: Colors.grey,
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setupFields();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: nameController,
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    icon: Icon(Icons.account_box_outlined),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    icon: Icon(Icons.mobile_friendly),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-Mail',
                    icon: Icon(Icons.email),
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              RaisedButton(
                child: Text(
                  buttonText
                ),
                onPressed: () {
                  if(nameController.text != "" ) {
                    contact.name = nameController.text;
                    contact.mobile = mobileController.text;
                    contact.email = emailController.text;
                    dynamic contactBox = Hive.box('contacts');
                    if(args['action'] == "New") {
                      contactBox.add(contact);
                    }
                    else if(args['action'] == "Update") {
                      contactBox.putAt(
                        args['index'],
                        contact,
                      );
                    }
                    Navigator.pop(context);
                  }
                }
              ),
            ],
          ),
        ),
      )
    );
  }
}
