import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum AcountType { Sender, receiver }

class TransferCard extends StatelessWidget {
  final String senderName;
  final double senderBalance;
  final File senderImage;
  final String receiverName;
  final double receiverBalance;
  final File receiverImage;
  final double amount;
  final DateTime date;
  TransferCard(
      {required this.senderName,
      required this.senderImage,
      required this.senderBalance,
      required this.receiverName,
      required this.receiverBalance,
      required this.receiverImage,
      required this.amount,
      required this.date});
  Widget columnBuilder(
      String name, File image, double balance, AcountType acountType) {
    Color textColor;
    String textSymbol = '';
    if (acountType == AcountType.Sender) {
      textColor = Colors.red;
      textSymbol = '-';
    } else {
      textColor = Colors.green;
      textSymbol = '+';
    }
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CircleAvatar(
          radius: 25,
          backgroundImage: FileImage(image),
        ),
        Text(
          "\$$balance $textSymbol",
          style: TextStyle(color: textColor),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        child: Container(
   
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                  child: columnBuilder(senderName, senderImage,
                      senderBalance + amount, AcountType.Sender)),
              Column(
                children: [
                  Icon(
                    Icons.arrow_forward,
                    size: 40,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "\$$amount",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    alignment: Alignment.center,
                    child: Text(
                      "${DateFormat.yMd().format(date)}",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              Expanded(
                child: columnBuilder(receiverName, receiverImage,
                    receiverBalance - amount, AcountType.receiver),
              )
            ],
          ),
        ));
  }
}
