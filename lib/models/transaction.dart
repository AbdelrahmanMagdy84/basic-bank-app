import 'dart:io';

class Transaction {
  int trId;
  String senderName;
  File senderImage;
  double senderBalance;
  String receiverName;
  File receiverImage;
  double receiverBalance;

  double amount;
  DateTime date;
  Transaction(
      {required this.trId,
      required this.senderName,
      required this.senderImage,
      required this.senderBalance,
      required this.receiverName,
      required this.receiverImage,
      required this.receiverBalance,
      required this.amount,
      required this.date});
}
