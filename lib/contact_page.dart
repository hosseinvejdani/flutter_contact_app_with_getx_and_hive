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
      backgroundColor: Colors.blueGrey[50],
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
      valueListenable: Hive.box(controller.dbName.string).listenable(),
      builder: (context, Box contactsBox, _) {
        return ListView.builder(
          itemCount: contactsBox.length,
          itemBuilder: (context, index) {
            final contact = controller.getContactByIndex(index);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Ink(
                color: Colors.white,
                child: ListTile(
                  title: Text(contact.name),
                  subtitle: Text(contact.number.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.amber,
                        ),
                        onPressed: () {
                          final Contact newContact =
                              Contact('${contact.name}*', contact.number + 1);
                          controller.updateContactByIndex(index, newContact);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          controller.deleteContactByIndex(index);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
