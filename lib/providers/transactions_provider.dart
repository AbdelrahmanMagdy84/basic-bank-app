import 'dart:io';
import '../helpers/db.helpers.dart';
import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsProvider extends ChangeNotifier {
  List<Transaction> _items = [];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
  List<Transaction> get getTransactions {
    return [..._items];
  }

  void insertTransaction(int senderId, int receiverId, double amount) {
    DBHelper.insert("transactions", {
      "senderId": senderId,
      "receiverId": receiverId,
      "amount": amount,
      "tr_date": dateFormat.format(DateTime.now())
    });
  }

  Future<void> fetchAndSetData() async {
    final data = await DBHelper.getData("transactions");
    print(data);
    try {
      _items = data.map((element) {
        return Transaction(
            trId: element["tr_id"] as int,
            senderName: element["senderName"] as String,
            senderImage: File(element["senderImage"]),
            senderBalance: element["senderBalance"] as double,
            receiverName: element["receiverName"] as String,
            receiverImage: File(element["receiverImage"]),
            receiverBalance: element["receiverBalance"] as double,
            amount: element["amount"] as double,
            date: dateFormat.parse(element["tr_date"]));
      }).toList();
    } catch (e) {
      print(e);
    }
    print(_items.length);
    notifyListeners();
  }
}
