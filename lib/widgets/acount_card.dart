import 'package:basic_banking/Cubit/new_transaction/new_transaction_cubit.dart';
import 'package:basic_banking/Cubit/transactions/transactions_cubit.dart';

import 'package:basic_banking/models/Acount.dart';
import 'package:basic_banking/screens/splash_screen.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
import 'package:flutter/material.dart';

import '../Cubit/acounts/acounts_cubit.dart';
import '../screens/acount_details_screen.dart';

class AcountCard extends StatelessWidget {
  final Acount acount;
  AcountCard(this.acount);

   void  onPressed(BuildContext context) {
    final newTranaction = NewTransactionCubit.getObj(context);
    if (newTranaction.inProcess()) {
      newTranaction.setReceiverID(acount.id);
      newTranaction.insertNewTransaction(context, AcountCubit.getObj(context),
          TransactionsCubit.getObj(context));

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
          pageBuilder: (_, __, ___) => AcountDetailsScreen(acount.id),
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
          tag: acount.id,
          child: CircleAvatar(
            radius: 25,
            backgroundImage: FileImage(acount.image!),
          ),
        ),
        title: Text(acount.name),
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
                  acount.email,
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
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "\$${acount.currentBalance.toString()}",
                style: const TextStyle(fontSize: 15),
              ),
            ],
          ),
        ),
        onTap: 
        ()=>onPressed(context),
      ),
    ));
  }
}
