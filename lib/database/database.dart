import 'dart:io';
import 'package:drift/drift.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get email => text()();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, "contact.sqlite"));
    return NativeDatabase(file);
  });
}

@DriftDatabase(tables:[Users])
class AppDatabase extends _$AppDatabase {
  AppDatabase():super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<User>> getListUsers() async {
    return await select(users).get();
  }

  Future<int> insertUser(UsersCompanion usersCompanion) async {
    return await into(users).insert(usersCompanion);
  }

  Future<int> deleteUser(UsersCompanion usersCompanion) async {
    return await delete(users).delete(usersCompanion);
  }

  Future<bool> updateUser(UsersCompanion usersCompanion) async {
    return await update(users).replace(usersCompanion);
  }
}