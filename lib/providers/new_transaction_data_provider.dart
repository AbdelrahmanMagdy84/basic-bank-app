import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/providers/transactions_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class NewTransactionDataProvider extends ChangeNotifier {
  int? _senderId;
  double? _amount;
  int? _receiverId;
  void setSenderID(senderId) {
    _senderId = senderId;
  }

  void setReceiverID(int receiverId) {
    _receiverId = receiverId;
  }

  void setAmount(double amount) {
    _amount = amount;
  }

  bool inProcess() {
    return _senderId != null;
  }

  int get getSenderID => _senderId!;

  static NewTransactionDataProvider getObject(BuildContext context) =>
      Provider.of<NewTransactionDataProvider>(context, listen: false);

  void insertNewTransaction(BuildContext context) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/");
    final cutomersProvider = Provider.of<Customers>(context, listen: false);

    final transactionsProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    transactionsProvider.insertTransaction(_senderId!, _receiverId!, _amount!);
    final sender = cutomersProvider.getCustomerByID(_senderId!);
    final receiver = cutomersProvider.getCustomerByID(_receiverId!);
    cutomersProvider.updateCustomersBalance(sender.id, sender.currentBalance,
        receiver.id, receiver.currentBalance, _amount!);
    dispose();
  }

  @override
  void dispose() {
    _senderId = null;
    _amount = null;
    _receiverId = null;
    super.dispose();
  }
}
