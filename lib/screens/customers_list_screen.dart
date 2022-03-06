import 'dart:io';
import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/widgets/customer_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import "package:path_provider/path_provider.dart" as syspaths;
import 'package:provider/provider.dart';

class CustomersListScreen extends StatefulWidget {
  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  File? _storedImage;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Bank"),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: const Text("Recent Transactions"),
          )
        ],
      ),
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
              return ListView.builder(
                itemCount: customersData.length,
                itemBuilder: (context, index) {
                  return CustomerCard(customersData[index]);
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
