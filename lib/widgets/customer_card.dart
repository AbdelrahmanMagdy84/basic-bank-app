import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/new_transaction_data_provider.dart';
import 'package:basic_banking/screens/customer_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  CustomerCard(this.customer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: ListTile(
          leading: Hero(
            tag: customer.id,
            child: CircleAvatar(
              radius: 25,
              backgroundImage: FileImage(customer.image!),
            ),
          ),
          title: Text(customer.name),
          subtitle: Row(
            children: [
              const Icon(
                Icons.mail,
                size: 15,
              ),
              Container(
                width: 120,
                child: FittedBox(
                  child: Text(
                    customer.email,
                    maxLines: 2,
                    style: const TextStyle(fontSize: 11),
                  ),
                ),
              ),
            ],
          ),
          trailing: Container(
            width: 95,
            child: Text(
              "\$${customer.currentBalance.toString()}",
              style: const TextStyle(fontSize: 15),
            ),
          ),
          onTap: () {
            final newTranaction =
                Provider.of<NewTransactionDataProvider>(context, listen: false);
            if (newTranaction.inProcess()) {
              newTranaction.setReceiverID(customer.id);
              newTranaction.insertNewTransaction(context);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("money sent has been successfully received")));
            } else {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(seconds: 1),
                    pageBuilder: (_, __, ___) =>
                        CustomerDetailsScreen(customer.id),
                  ));
            }
          },
        ),
      ),
    );
  }
}
