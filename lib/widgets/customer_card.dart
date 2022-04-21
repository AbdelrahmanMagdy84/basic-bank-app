import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/new_transaction_data_provider.dart';
import 'package:basic_banking/screens/customer_details_screen.dart';
import 'package:basic_banking/screens/splash_screen.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  CustomerCard(this.customer);
  void onPressed(BuildContext context) {
    final newTranaction =
        Provider.of<NewTransactionDataProvider>(context, listen: false);
    if (newTranaction.inProcess()) {
      newTranaction.setReceiverID(customer.id);
      newTranaction.insertNewTransaction(context);

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => SplashScreen(
                "Money has been transferred successfully",
                Icons.check_circle_outlined)),
      );
    } else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 1),
          pageBuilder: (_, __, ___) => CustomerDetailsScreen(customer.id),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      decoration: BoxDecoration(
        gradient: GradientWidget.linearGradientBuilder(context, opacity: 0.3),
      ),
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
            SizedBox(
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
        trailing: SizedBox(
          width: 95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Balance:",
                style:
                     TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "\$${customer.currentBalance.toString()}",
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        onTap: () => onPressed(context),
      ),
    ));
  }
}
