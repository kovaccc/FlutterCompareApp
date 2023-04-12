import 'package:drift/drift.dart';

class Photos extends Table {
  IntColumn get id => integer()();

  TextColumn get title => text()();

  TextColumn get url => text()();
}
