import 'package:flutter/material.dart';

import 'models/contact.dart';

class LiteralContactButton extends StatelessWidget {
  const LiteralContactButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 100,
          width: 100,
          child: ElevatedButton(
            onPressed: () => contactListRoute(context),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(Theme.of(context).primaryColor),
              shape: MaterialStateProperty.all(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Icon(Icons.people, color: Colors.white),
                Text(
                  "Contacts",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ));
  }

  void contactListRoute(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ContactList()));
  }
}

class ContactList extends StatefulWidget {
  ContactList({Key? key}) : super(key: key);

  final List<Contact> contactList = [];

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addContactRoute(context),
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 230, 230, 230),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.contactList.length,
        itemBuilder: itemBuilder,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int i) {
    var item = widget.contactList[i];

    return Card(
      child: ListTile(
        title: Text(item.name),
        subtitle: Text(item.phoneNumber),
      ),
    );
  }

  void addContactRoute(BuildContext context) {
    Future promise = Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddContact()));

    promise.then((value) => {
          if (value is Contact)
            {
              setState(() {
                widget.contactList.add(value);
              })
            }
        });
  }
}

class AddContact extends StatefulWidget {
  AddContact({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: widget.nameController,
                decoration: const InputDecoration(
                  label: Text("Name"),
                  hintText: "Ex: Gabriel Saito",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: widget.phoneController,
                decoration: const InputDecoration(
                  label: Text("Phone Number"),
                  hintText: "+5512345678910",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => addToList(context),
              child: const Text("Adicionar"),
            )
          ],
        ),
      ),
    );
  }

  void addToList(BuildContext context) {
    var name = widget.nameController.text;
    var phone = widget.phoneController.text;
    var contact = Contact(name: name, phoneNumber: phone);

    Navigator.pop(context, contact);
  }
}
