import 'package:hive/hive.dart';

part 'contact.g.dart';

@HiveType(typeId: 0)
class Contact {
  @HiveField(0)
  String name;
  @HiveField(1)
  String mobile;
  @HiveField(2)
  String email;
  @HiveField(100)
  String image;
  Contact({this.name = "", this.mobile = "", this.email = "", this.image});
}