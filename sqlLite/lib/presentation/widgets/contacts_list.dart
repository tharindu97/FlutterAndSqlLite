import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqlLite/models/contact.dart';
import 'package:sqlLite/presentation/pages/edit_contact.dart';


// ignore: must_be_immutable
class ContactsList extends StatelessWidget {
  List<Contact> contacts;

  // ignore: type_init_formals
  ContactsList(List<Contact> this.contacts, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: Key('${contacts[index].id}'),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ' ${contacts[index].id} ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' ${contacts[index].name}  ${contacts[index].surname}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditContactPage(
                                            contact: contacts[index],
                                          )));
                            },
                            color: Colors.orange,
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            onDismissed: (direction) {},
          );
        },
      ),
    );
  }
}
