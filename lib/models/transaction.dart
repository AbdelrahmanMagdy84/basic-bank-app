class Transaction {
  int senderId;
  int receiverId;
  double amount;
  DateTime? date;
  Transaction(
      {required this.senderId,
      required this.receiverId,
      required this.amount,
      required date});
}
