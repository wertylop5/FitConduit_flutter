import "dart:async";
import "dart:convert";
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

import "../model/cable.dart";

const DATA_PATH = "lib/data/";
const CABLE_INIT_FILE = "cables.json";

const DB_FILE = "thing.db";
const CABLE_TABLE = "cables";
const CONDUIT_TABLE = "conduits";

void _createTables(Database db) async {
  await db.execute("""
    CREATE TABLE cables (
      id INTEGER PRIMARY KEY,
      name TEXT,
      od REAL
    );
  """);
  
  await db.execute("""
    CREATE TABLE conduits (
      id INTEGER PRIMARY KEY,
      name TEXT,
      area REAL
    );
  """);
  
  //if user wants to save the cables they're working
  //with
  await db.execute("""
    CREATE TABLE workspaces (
      id INTEGER PRIMARY KEY,
      name TEXT
    );
  """);
  
  //mapping of cables used in a workspace
  //cable_known: 1 use cable_id, 0 use od
  await db.execute("""
    CREATE TABLE workspace_cables (
      workspace_id INTEGER,
      cable_known INTEGER,
      cable_id INTEGER,
      od REAL,
      cable_count INTEGER
    );
  """);
}

void _addInitData(Database db, BuildContext context) {
  //for getting the data file
  AssetBundle bundle = DefaultAssetBundle.of(context);
  
  Stream.fromFuture(bundle.loadString(
      join(DATA_PATH, CABLE_INIT_FILE)))
    .transform(json.decoder)//string to dynamic type
    .listen((dynamic data) {//should be a list
      print(data.length);
      
      Batch batch = db.batch();
      data.forEach((dynamic elem) {
        batch.insert(CABLE_TABLE, {
          "name": elem["name"],
          "od": elem["od"],
        });
      });
      
      batch.commit().then((List<dynamic> value) {
        print(value);
      });
    });
}

Future<Database> dbOpen(BuildContext context) async {
  String dbPath = await getDatabasesPath();
  return await openDatabase(join(dbPath, DB_FILE),
      version: 1,
      onCreate: (Database db, int version) {
        _createTables(db);
        _addInitData(db, context);
        print("db created");
      },
      onOpen: (Database db) async {
        print("db opened");
        //await getCables(db);
        //await dbDelete();
      },
  );
}

Future dbDelete() async {
  String dbPath = await getDatabasesPath();
  await deleteDatabase(join(dbPath, DB_FILE));
  print("db deleted");
  return;
}

Future<List<Cable>> getCables(Database db) async {
  List<Map<String, dynamic>> results = 
    await db.query(CABLE_TABLE);
  
  List<Cable> res = List();
  results.forEach((Map<String, dynamic> elem) {
    //print("${elem["name"]}: ${elem["od"]}");
    res.add(Cable(elem["name"], elem["od"]));
  });
  return res;
}

