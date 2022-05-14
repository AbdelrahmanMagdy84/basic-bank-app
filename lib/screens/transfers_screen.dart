
import 'package:basic_banking/Cubit/transactions/transactions_cubit.dart';
import 'package:basic_banking/widgets/transafer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Cubit/transactions/transactions_states.dart';
import '../widgets/gradient_color_widget.dart';

class TransfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TransactionsCubit.getObj(context).fetchAndSetData(),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return GradientWidget(
            const Scaffold(
              body: Center(
                child: Text(
                  "Loading",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        }
        return BlocBuilder<TransactionsCubit, TransactionsStates>(
          builder: (context, state) {
            var transactions = [];
            if (state is FetchTransactionsState) {
              transactions = state.transactions;
            }
            return transactions.isEmpty
                ? Center(
                    child: Text(
                    "No transactions yet",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 22),
                  ))
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (transaction, index) {
                      return TransferCard(
                        senderName: transactions[index].senderName,
                        senderImage: transactions[index].senderImage,
                        senderBalance: transactions[index].senderBalance,
                        receiverName: transactions[index].receiverName,
                        receiverBalance: transactions[index].receiverBalance,
                        receiverImage: transactions[index].receiverImage,
                        amount: transactions[index].amount,
                        date: transactions[index].date,
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
