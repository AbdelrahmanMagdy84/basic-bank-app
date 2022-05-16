import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper instance = DBHelper._();
  static Database? _database;

  final joinQuery =
      "select transactions1.Tr_id as tr_id,transactions1.name as senderName,transactions1.image AS senderImage,transactions1.balance senderBalance ,transactions2.name as receiverName,transactions2.image AS receiverImage,transactions2.balance as receiverBalance,amount,transactions1.tr_date as tr_date from(select Tr_id,name,image,balance,amount,tr_date   from transactions inner Join customer where senderId = id )as transactions1 inner join (select  Tr_id,name,image,balance  from transactions inner Join customer where receiverId = id) as transactions2 where transactions1.Tr_id=transactions2.Tr_id order by transactions1.tr_date desc;";

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    const customerTableQuery =
        "CREATE TABLE customer(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,email TEXT, balance DOUBLe,image TEXT);";
    const transactionTableQuery =
        "CREATE TABLE transactions(Tr_id INTEGER PRIMARY KEY AUTOINCREMENT,senderId INTEGER,receiverId INTEGER,amount DOUBLe,tr_date TEXT,FOREIGN KEY (senderId) REFERENCES customer (id),FOREIGN KEY (receiverId) REFERENCES customer (id));";
    try {
      var databasePath = await sql.getDatabasesPath();
      return await sql.openDatabase(path.join(databasePath, "bank.db"),
          version: 1, onCreate: (database, _) async {
        await database.execute(customerTableQuery);
        await database.execute(transactionTableQuery);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> insert(String table, Map<String, Object> insertedData) async {
    try {
      var database = await instance.database;
      await database.insert(table, insertedData);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>?> queryAllRows(String table) async {
    try {
      var database = await instance.database;
      if (table == "transactions") {
        return await database.rawQuery(joinQuery);
      }
      List<Map<String, dynamic>>? data = await database.query("customer");
      return data;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> update(int senderId, double newSenderBalance, int receiverId,
      double newReceiverBalance) async {
    var database = await instance.database;
    await database.update("customer", {"balance": newSenderBalance},
        where: "id = ?", whereArgs: [senderId]);
    await database.update("customer", {"balance": newReceiverBalance},
        where: "id = ?", whereArgs: [receiverId]);
  }
}
