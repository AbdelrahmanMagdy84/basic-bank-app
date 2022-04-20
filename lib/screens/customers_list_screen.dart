import 'dart:io';
import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/providers/new_transaction_data_provider.dart';
import 'package:basic_banking/widgets/customer_card.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersListScreen extends StatefulWidget {
  static const String routeName = "/customers' List screen";
  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  // File? _storedImage;

  // Future<void> takePicture() async {
  //   final imageFile = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, maxWidth: 600);
  //   if (imageFile == null) {
  //     return;
  //   }
  //   setState(() {
  //     _storedImage = File(imageFile.path);
  //   });
  //   final appDir = await syspaths.getApplicationDocumentsDirectory();
  //   final fileName = path.basename(imageFile.path);
  //   final savedImage = await _storedImage!.copy("${appDir.path}/$fileName");

  //   Provider.of<Customers>(context, listen: false).insertCustomer(savedImage);
  // }
  Future<void> empty() async {}
  @override
  Widget build(BuildContext context) {
    List<Customer> customersData = [];
    return Consumer2<NewTransactionDataProvider, Customers>(
      builder: (ctx, newTransactionData, customers, child) {
        if (newTransactionData.inProcess()) {
          customersData =
              customers.getCustomersExcept(newTransactionData.getSenderID);
        } else {
          customersData = customers.getCustomers;
        }
        return FutureBuilder(
          future: newTransactionData.inProcess()
              ? Future<bool>.value(true)
              : customersData.isEmpty
                  ? Provider.of<Customers>(context, listen: false)
                      .fetchAndSetCustomers()
                  : Future<bool>.value(true),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return GradientWidget(
                const Scaffold(
                  body: Center(
                    child: Text(
                      "Loading",
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
                appBar: newTransactionData.inProcess()
                    ? AppBar(
                        flexibleSpace: Container(
                          decoration: BoxDecoration(
                              gradient: GradientWidget.linearGradientBuilder(
                                  context)),
                        ),
                        toolbarHeight: 100,
                        title: const Text(
                          "select the receiving acount",
                          maxLines: 2,
                        ),
                      )
                    : null,
                body: customersData.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: customersData.length,
                        itemBuilder: (context, index) {
                          return CustomerCard(
                            customersData[index],
                          );
                        },
                      )
                // floatingActionButton: FloatingActionButton(
                //   onPressed: takePicture,
                // ),
                );
          },
        );
      },
    );
  }
}
