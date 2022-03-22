import 'dart:io';
import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/providers/new_transaction_data_provider.dart';
import 'package:basic_banking/providers/transactions_provider.dart';
import 'package:basic_banking/widgets/customer_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import "package:path_provider/path_provider.dart" as syspaths;
import 'package:provider/provider.dart';

class CustomersListScreen extends StatefulWidget {
  static const String routeName = "/customers' List screen";
  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  File? _storedImage;
  late Future fetch;
  @override
  void initState() {
    fetch =
        Provider.of<Customers>(context, listen: false).fetchAndSetCustomers();
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return Consumer2<NewTransactionDataProvider, Customers>(
      builder: (context, newTransactionData, customers, child) {
        return Scaffold(
          appBar: newTransactionData.inProcess()
              ? AppBar(
                  toolbarHeight: 100,
                  title: Text(
                    "select the receiving acount",
                    maxLines: 2,
                  ),
                )
              : null,
          body: FutureBuilder(
            future: fetch,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              var customersData = customers.getCustomers;
              if (newTransactionData.inProcess()) {
                customersData = customers
                    .getCustomersExcept(newTransactionData.getSenderID);
              }
              return ListView.builder(
                itemCount: customersData.length,
                itemBuilder: (context, index) {
                  return CustomerCard(
                    customersData[index],
                  );
                },
              );
            },
          ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: takePicture,
          // ),
        );
      },
    );
  }
}
