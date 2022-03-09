import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/widgets/transfer_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomerDetailsScreen extends StatelessWidget {
  int targetedCustomerId;
  CustomerDetailsScreen(this.targetedCustomerId);
  static const String routeName = "/customer details screen";
  FittedBox textBuilder(String title, String value) {
    return FittedBox(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Acount Details")),
      body: Consumer<Customers>(
        builder: (context, customers, child) {
          final currentCustomer = customers.getCustomerByID(targetedCustomerId);
          return SingleChildScrollView(
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                alignment: Alignment.center,
                //  padding: const EdgeInsets.all(10),
                child: Hero(
                  tag: currentCustomer.id,
                  child: CircleAvatar(
                    radius: 100,
                    backgroundImage: FileImage(
                      currentCustomer.image!,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: textBuilder("Name: ", currentCustomer.name),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: textBuilder("Email: ", currentCustomer.email),
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: textBuilder(
                          "Balance: ", "\$${currentCustomer.currentBalance}"),
                    ),
                  ],
                ),
              ),
              TransferInputWidget(
                  currentCustomer.id, currentCustomer.currentBalance)
            ]),
          );
        },
      ),
    );
  }
}
