import 'dart:io';

import 'package:drift/drift.dart';
// These imports are used to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shop_price_list/models/item.dart';

part 'database.g.dart';

@DriftDatabase(
    // relative import for the drift file. Drift also supports `package:`
    // imports
    tables: [Items])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<Item> createItemRepo(String name, String type, int price) async {
    return await into(items).insertReturning(ItemsCompanion.insert(
      name: name,
      type: type,
      price: price,
    ));
  }

  Future<List<Item>> getAllItemsRepo() async {
    return await select(items).get();
  }

  Future<Item> getItemByIdRepo(int id) async {
    return await (select(items)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> updateItemByIdRepo(int id, Item item) async {
    return await (update(items)..where((tbl) => tbl.id.equals(id))).write(ItemsCompanion(
      name: Value(item.name),
      price: Value(item.price),
      type: Value(item.type),
    ));
  }

  Future<int> deleteItemByIdRepo(int id) async {
    return await (delete(items)..where((tbl) => tbl.id.equals(id))).go();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    return NativeDatabase.createInBackground(file);
  });
}
