import 'package:basic_banking/models/customer.dart';
import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  CustomerCard(this.customer);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          margin: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(backgroundImage: FileImage(customer.image!)),
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
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                ),
              ],
            ),
            trailing: Container(
              width: 95,
              child: Text(
                "\$${customer.currentBalance.toString()}",
                style: TextStyle(fontSize: 15),
              ),
            ),
          )),
    );
  }
}
