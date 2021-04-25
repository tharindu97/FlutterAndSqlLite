import 'package:sqlLite/data/database.dart';
import 'package:sqlLite/models/contact.dart';

class ContactOperations{

  DatabaseRepository databaseRepository = DatabaseRepository.instance;

  createContact(Contact contact) async {
    final db = await databaseRepository.database;
    print(contact.name);
    db.insert('contacts', contact.toMap());
    print('Data Add');
  }

  updateContact(Contact contact) async {
    final db = await databaseRepository.database;
    db.update('contacts', contact.toMap(), where: 'contactId=?', whereArgs: [contact.id]);
  }

  deleteContact(Contact contact) async {
    final db = await databaseRepository.database;
    db.delete('contacts', where: 'contactId=?', whereArgs: [contact.id]);
  } 

  Future<List<Contact>> getAllContacts() async {
    final db = await databaseRepository.database;
    var allRows = await db.query('contacts');
    List<Contact> contacts = allRows.map((contact) => Contact.fromMap(contact)).toList();
    return contacts;
  }
}