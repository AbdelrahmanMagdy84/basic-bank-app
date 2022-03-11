import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/new_transaction_data_provider.dart';
import 'package:basic_banking/screens/customer_details_screen.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  CustomerCard(this.customer);

  @override
  Widget build(BuildContext context) {
    void targetDetailsScreen(id) {
      Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 1),
            pageBuilder: (_, __, ___) => CustomerDetailsScreen(id),
          ));
    }

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
            final newTranaction = NewTransactionDataProvider.getObject(context);
            if (newTranaction.inProcess()) {
              newTranaction.setReceiverID(customer.id);
              newTranaction.insertNewTransaction(context);
            } else {
              targetDetailsScreen(customer.id);
            }
          },
        ),
      ),
    );
  }
}
