import 'package:basic_banking/models/Acount.dart';
import 'package:basic_banking/models/transaction.dart';


abstract class TransactionsStates{
  
}
class InittransactionsState extends TransactionsStates{}
class FetchTransactionsState extends TransactionsStates{
  List<Transaction> transactions = [];
  FetchTransactionsState(this.transactions);
}