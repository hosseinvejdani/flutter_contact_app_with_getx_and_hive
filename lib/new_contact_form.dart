import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/controller.dart';
import 'models/contact.dart';

class NewContactForm extends StatelessWidget {
  NewContactForm({Key? key}) : super(key: key);

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    controller: controller.addNameController.value,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: controller.addNumberController.value,
                    decoration: const InputDecoration(labelText: 'Number'),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
              child: const Text('Add New Contact'),
              onPressed: () {
                if (controller.addNameController.value.text != '' &&
                    controller.addNumberController.value.text != '') {
                  final newContact = Contact(
                    controller.addNameController.value.text,
                    int.parse(controller.addNumberController.value.text),
                  );
                  // ignore: avoid_print
                  print(
                      'add contact : ${newContact.name} ${newContact.number}');
                  controller.addContact(newContact);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
