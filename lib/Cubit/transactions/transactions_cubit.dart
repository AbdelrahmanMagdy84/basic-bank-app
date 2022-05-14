import 'dart:io';
import 'package:basic_banking/Cubit/transactions/transactions_states.dart';
import 'package:basic_banking/helpers/db.helpers.dart';
import 'package:basic_banking/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionsCubit extends Cubit<TransactionsStates> {
  TransactionsCubit() : super(InittransactionsState());
  List<Transaction> _transactions = [];
  DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  static TransactionsCubit getObj(BuildContext ctx) {
    return BlocProvider.of<TransactionsCubit>(ctx);
  }

  List<Transaction> get getTransactions {
    return [..._transactions];
  }

  Future<void> fetchAndSetData() async {
    final data = await DBHelper.getData("transactions");

    try {
      _transactions = data.map((element) {
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

    emit(FetchTransactionsState(getTransactions));
  }

   insertTransaction(int senderId, int receiverId, double amount) {
    DBHelper.insert("transactions", {
      "senderId": senderId,
      "receiverId": receiverId,
      "amount": amount,
      "tr_date": dateFormat.format(DateTime.now())
    });
  }


}
