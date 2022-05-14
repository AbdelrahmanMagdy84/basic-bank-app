import 'package:basic_banking/Cubit/new_transaction/new_transaction_state.dart';
import 'package:basic_banking/Cubit/transactions/transactions_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../acounts/acounts_cubit.dart';

class NewTransactionCubit extends Cubit<NewTransactionState> {
  NewTransactionCubit() : super(InitNewTransactionState());
  int? _senderId;
  double? _amount;
  int? _receiverId;

  static NewTransactionCubit getObj(BuildContext ctx) {
    return BlocProvider.of<NewTransactionCubit>(ctx);
  }

  void setSenderID(senderId) {
    _senderId = senderId;
    emit(ProcessingNewTransactionState());
  }

  void setReceiverID(int receiverId) {
    _receiverId = receiverId;
    emit(ProcessingNewTransactionState());
  }

  void setAmount(double amount) {
    _amount = amount;
  }

  bool inProcess() {
    return state is ProcessingNewTransactionState;
  }

  int get getSenderID => _senderId!;
  int get getReceiverID => _receiverId!;
  double get getAmout => _amount!;

  void clean() {
    _senderId = null;
    _amount = null;
    _receiverId = null;
    emit(InitNewTransactionState());
  }

  Future<void> insertNewTransaction(BuildContext context,
      AcountCubit acountCubit, TransactionsCubit transactionsCubit) async {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/");
    transactionsCubit.insertTransaction(getSenderID, getReceiverID, getAmout);
    final sender = acountCubit.getAcountByID(_senderId!);
    final receiver = acountCubit.getAcountByID(_receiverId!);
    await acountCubit.updateCustomersBalance(sender.id, sender.currentBalance,
        receiver.id, receiver.currentBalance, _amount!);
    emit(InsertedNewTransactionState());
    clean();
  }

  @override
  void onChange(Change<NewTransactionState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
}
