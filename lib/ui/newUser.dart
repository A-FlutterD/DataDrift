import 'package:flutter/material.dart';
import 'package:app_drift/database/database.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as dr;

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  late AppDatabase appDatabase;
  late TextEditingController txtName;
  late TextEditingController txtEmail;

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController();
    txtEmail = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    appDatabase = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("New User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextFormField(
              controller: txtName,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                hintText: "Enter name"
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: txtEmail,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  hintText: "Enter email"
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                appDatabase.insertUser(UsersCompanion(
                  name: dr.Value(txtName.text),
                  email: dr.Value(txtEmail.text)
                )).then((value) {
                  Navigator.pop(context, true);
                });
              },
              child: const Text("Record user"),
            )
          ],
        ),
      ),
    );
  }
}
