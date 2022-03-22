import 'package:basic_banking/providers/transactions_provider.dart';
import 'package:basic_banking/widgets/transafer_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TransfersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TransactionsProvider>(context, listen: false)
          .fetchAndSetData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        return Consumer<TransactionsProvider>(
          builder: (context, transactions, child) {
            final transactionsData = transactions.getTransactions;
            return transactions.getTransactions.isEmpty
                ? Center(child: Text("No transactions yet",style: TextStyle(color: Theme.of(context).colorScheme.onPrimary,fontSize: 22),))
                : ListView.builder(
                 
                    itemCount: transactionsData.length,
                    itemBuilder: (transaction, index) {
                      return TransferCard(
                        senderName: transactionsData[index].senderName,
                        senderImage: transactionsData[index].senderImage,
                        senderBalance: transactionsData[index].senderBalance,
                        receiverName: transactionsData[index].receiverName,
                        receiverBalance:
                            transactionsData[index].receiverBalance,
                        receiverImage: transactionsData[index].receiverImage,
                        amount: transactionsData[index].amount,
                        date: transactionsData[index].date,
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
