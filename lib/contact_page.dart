import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './controllers/controller.dart';
import './models/contact.dart';
import './new_contact_form.dart';

class ContactPage extends StatelessWidget {
  ContactPage({Key? key}) : super(key: key);

  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('Contacts'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildListView()),
          NewContactForm(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return ValueListenableBuilder(
      valueListenable: Hive.box('contacts').listenable(),
      builder: (context, Box contactsBox, _) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = controller.getContactByIndex(index);
            return ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.number.toString()),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      final Contact newContact =
                          Contact('${contact.name}*', contact.number + 1);
                      controller.updateContactByIndex(index, newContact);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      controller.deleteContactByIndex(index);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
