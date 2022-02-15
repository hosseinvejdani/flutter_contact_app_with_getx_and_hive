import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/controller.dart';
import 'models/contact.dart';

class NewContactForm extends StatelessWidget {
  NewContactForm({Key? key}) : super(key: key);

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: controller.nameController.value,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: controller.numberController.value,
                  decoration: const InputDecoration(labelText: 'Number'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
            child: const Text('Add New Contact'),
            onPressed: () {
              if (controller.nameController.value.text != '' &&
                  controller.numberController.value.text != '') {
                final newContact = Contact(
                  controller.nameController.value.text,
                  int.parse(controller.numberController.value.text),
                );
                // ignore: avoid_print
                print('add contact : ${newContact.name} ${newContact.number}');
                controller.addContact(newContact);
              }
            },
          ),
        ],
      ),
    );
  }
}
