import 'dart:io';
import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/customers_provider.dart';
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

  void insertNewTransaction(int senderId, double amount, int receiverId) {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, "/");
    final cutomersProvider = Provider.of<Customers>(context, listen: false);

    final transactionProvider =
        Provider.of<TransactionsProvider>(context, listen: false);
    transactionProvider.insertTransaction(senderId, receiverId, amount);
    final sender = cutomersProvider.getCustomerByID(senderId);
    final receiver = cutomersProvider.getCustomerByID(receiverId);
    cutomersProvider.updateCustomersBalance(sender.id, sender.currentBalance,
        receiver.id, receiver.currentBalance, amount);
  }

  Future<void> takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy("${appDir.path}/$fileName");

    Provider.of<Customers>(context, listen: false).insertCustomer(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, Object>? data =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>?;
    int senderId = -1;
    double amountToTransfer = -1;
    if (data != null) {
      senderId = data["senderId"] as int;
      amountToTransfer = data["amount"] as double;
    }

    return Scaffold(
      appBar: data != null
          ? AppBar(
              toolbarHeight: 100,
              title: Text(
                "select the receiving acount",
                maxLines: 2,
              ),
            )
          : null,
      body: FutureBuilder(
        future: Provider.of<Customers>(context, listen: false)
            .fetchAndSetCustomers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return Consumer<Customers>(
            builder: (context, customers, _) {
              final customersData = customers.getCustomers;
              if (data != null) {
                customersData.removeWhere((element) {
                  return element.id == senderId;
                });
              }
              return ListView.builder(
                itemCount: customersData.length,
                itemBuilder: (context, index) {
                  return CustomerCard(
                      customersData[index],
                      senderId,
                      insertNewTransaction,
                      data == null ? false : true,
                      amountToTransfer);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takePicture,
      ),
    );
  }
}
