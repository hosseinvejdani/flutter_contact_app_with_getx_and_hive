import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './bindings/binding.dart';
import './models/contact.dart';
import './contact_page.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  await Hive.openBox('contacts');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Contacts',
      initialRoute: '/home',
      getPages: [
        GetPage(
          name: '/home',
          page: () => ContactPage(),
          binding: ContactBinding(),
        ),
      ],
    );
  }
}
