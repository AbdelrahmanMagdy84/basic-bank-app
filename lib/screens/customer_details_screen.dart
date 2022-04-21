import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
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
      appBar: AppBar(
        title: GradientWidget(Text(
          "Acount Details",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: GradientWidget.linearGradientBuilder(context)),
        child: Consumer<Customers>(
          builder: (context, customers, child) {
            final currentCustomer =
                customers.getCustomerByID(targetedCustomerId);
            return SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
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
                Container(
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
      ),
    );
  }
}
