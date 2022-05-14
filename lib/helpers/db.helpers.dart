
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static const joinQuery =
      "select transactions1.Tr_id as tr_id,transactions1.name as senderName,transactions1.image AS senderImage,transactions1.balance senderBalance ,transactions2.name as receiverName,transactions2.image AS receiverImage,transactions2.balance as receiverBalance,amount,transactions1.tr_date as tr_date from(select Tr_id,name,image,balance,amount,tr_date   from transactions inner Join customer where senderId = id )as transactions1 inner join (select  Tr_id,name,image,balance  from transactions inner Join customer where receiverId = id) as transactions2 where transactions1.Tr_id=transactions2.Tr_id order by transactions1.tr_date desc;";
  static Future<Database> database() async {
    const customerTableQuery =
        "CREATE TABLE customer(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT, balance DOUBLe,image TEXT);";
    const transactionTableQuery =
        "CREATE TABLE transactions(Tr_id INTEGER PRIMARY KEY AUTOINCREMENT,senderId INTEGER,receiverId INTEGER,amount DOUBLe,tr_date TEXT,FOREIGN KEY (senderId) REFERENCES customer (id),FOREIGN KEY (receiverId) REFERENCES customer (id));";

    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, "bank.db"), version: 1,
        onCreate: (db, _) async {
      await db.execute(customerTableQuery);
      await db.execute(transactionTableQuery);
    });
  }

  static Future<void> insert(

      String table, Map<String, Object> insertedData) async {
    try {
      final db = await DBHelper.database();
     await db.insert(table, insertedData);
    } catch (e) {
      print(e.toString())
      ;
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    if (table == "transactions") {
      return db.rawQuery(DBHelper.joinQuery);
    }
    return db.query(table);
  }

  static Future<void> update(int senderId, double newSenderBalance,
      int receiverId, double newReceiverBalance) async {
    final db = await DBHelper.database();
    await db.update("customer", {"balance": newSenderBalance},
        where: "id = ?", whereArgs: [senderId]);
    await db.update("customer", {"balance": newReceiverBalance},
        where: "id = ?", whereArgs: [receiverId]);
  }
}
