import 'package:drift/drift.dart';

class Item extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  IntColumn get price => integer()();
}
