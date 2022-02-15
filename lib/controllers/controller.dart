import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/contact.dart';

class ContactController extends GetxController {
  static const String dbName = 'contacts';

  final RxList _contacts = [].obs;

  final Rx<TextEditingController> _nameController = TextEditingController().obs;
  final Rx<TextEditingController> _numberController =
      TextEditingController().obs;

  @override
  onInit() {
    addDefaultContacts();
    getContacts();
    super.onInit();
  }

  RxList get contacts => _contacts;
  Rx<TextEditingController> get nameController => _nameController;
  Rx<TextEditingController> get numberController => _numberController;

  void addDefaultContacts() {
    final contactsBox = Hive.box(dbName);
    if (contactsBox.isEmpty) {
      // these are initial default contacts
      addContact(Contact('minoo', 3305656));
      addContact(Contact('hossein', 66595658));
      addContact(Contact('taha', 889755665));
    }
  }

  void cleanForm() {
    _nameController.value.clear();
    _numberController.value.clear();
  }

  void addContact(Contact contact) {
    final contactsBox = Hive.box(dbName);
    contactsBox.add(contact);
    cleanForm();
    // ignore: avoid_print
    print('add contact : ${contact.name} ${contact.number}');
  }

  getContactByIndex(int index) {
    final contactsBox = Hive.box(dbName);
    return contactsBox.getAt(index) as Contact;
  }

  deleteContactByIndex(int index) {
    final contactsBox = Hive.box(dbName);
    contactsBox.deleteAt(index);
  }

  updateContactByIndex(int index, Contact contact) {
    final contactsBox = Hive.box(dbName);
    contactsBox.putAt(index, contact);
  }

  Future getContacts() async {
    Box box;
    // Getting contacts
    try {
      box = Hive.box(dbName);
    } catch (error) {
      box = await Hive.openBox(dbName);
      // ignore: avoid_print
      print(error);
    }

    var allContacts = box.get(dbName);
    if (allContacts != null) _contacts.value = allContacts;
  }
}
