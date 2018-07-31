import "dart:async";
import "dart:convert";
import "dart:io";

import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

import "../model/Cable.dart";

const DATA_PATH = "lib/util/data/";
const CABLE_INIT_FILE = "cables.json";

const DB_FILE = "thing.db";
const CABLE_TABLE = "cables";
const CONDUIT_TABLE = "conduits";

void _addInitData(Database db) {
  Stream<List<int>> s =
    File(join(DATA_PATH, CABLE_INIT_FILE)).openRead();
  
  s
    .transform(utf8.decoder)//raw int to string
    .transform(json.decoder)//string to dynamic type
    .listen((dynamic data) {
      print(data);
    });
}

Future<Database> dbOpen() async {
  String dbPath = await getDatabasesPath();
  return await openDatabase(join(dbPath, DB_FILE),
      version: 1,
      onCreate: (Database db, int version) {
        print("db created");
        //_addInitData(db);
      },
      onOpen: (Database db) {
        print("db opened");
        _addInitData(db);
      },
  );
}

void dbDelete() async {
  String dbPath = await getDatabasesPath();
  await deleteDatabase(join(dbPath, DB_FILE));
  print("db deleted");
  return;
}

Future<List<Cable>> getCables() async {
  Database db = await dbOpen();
}

