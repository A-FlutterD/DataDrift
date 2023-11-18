import 'package:app_drift/database/database.dart';
import 'package:app_drift/ui/newUser.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListUser extends StatefulWidget {
  const ListUser({super.key});

  @override
  State<ListUser> createState() => _ListUserState();
}

class _ListUserState extends State<ListUser> {
  late AppDatabase database;

  @override
  Widget build(BuildContext context) {
    database = Provider.of<AppDatabase>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("User list..."),
      ),
      body: FutureBuilder<List<User>>(
        future: database.getListUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User>? userList = snapshot.data;
            return ListView.builder(
              itemCount: userList!.length,
              itemBuilder: (context, index) {
                User userData = userList[index];
                return ListTile(
                  title: Text(userData.name),
                  subtitle: Text(userData.email),
                );
              },
            );
          }
          else {
            return const Center(
              child: Text(""),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addUser();
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addUser() async {
    var res = await Navigator.push(context, MaterialPageRoute(builder: (context) => const NewUser()));

    if (res != null && res == true) {
      setState(() {

      });
    }
  }
}
