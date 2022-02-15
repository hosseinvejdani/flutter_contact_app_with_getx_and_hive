import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/contact.dart';

class ContactController extends GetxController {
  final RxString dbName = 'contacts'.obs;

  final RxList _contacts = [].obs;

  final Rx<TextEditingController> _addNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> _addNumberController =
      TextEditingController().obs;

  @override
  onInit() {
    addDefaultContacts();
    getContacts();
    super.onInit();
  }

  RxList get contacts => _contacts;
  Rx<TextEditingController> get addNameController => _addNameController;
  Rx<TextEditingController> get addNumberController => _addNumberController;

  void addDefaultContacts() {
    final contactsBox = Hive.box(dbName.value);
    if (contactsBox.isEmpty) {
      // these are initial default contacts
      addContact(Contact('minoo', 3305656));
      addContact(Contact('hossein', 66595658));
      addContact(Contact('taha', 889755665));
    }
  }

  void cleanForm() {
    _addNameController.value.clear();
    _addNumberController.value.clear();
  }

  void addContact(Contact contact) {
    final contactsBox = Hive.box(dbName.value);
    contactsBox.add(contact);
    cleanForm();
    // ignore: avoid_print
    print('add contact : ${contact.name} ${contact.number}');
  }

  getContactByIndex(int index) {
    final contactsBox = Hive.box(dbName.value);
    return contactsBox.getAt(index) as Contact;
  }

  deleteContactByIndex(int index) {
    final contactsBox = Hive.box(dbName.value);
    contactsBox.deleteAt(index);
  }

  updateContactByIndex(int index, Contact contact) {
    final contactsBox = Hive.box(dbName.value);
    contactsBox.putAt(index, contact);
  }

  Future getContacts() async {
    Box box;
    // Getting contacts
    try {
      box = Hive.box(dbName.value);
    } catch (error) {
      box = await Hive.openBox(dbName.value);
      // ignore: avoid_print
      print(error);
    }

    var allContacts = box.get(dbName.value);
    if (allContacts != null) _contacts.value = allContacts;
  }
}
