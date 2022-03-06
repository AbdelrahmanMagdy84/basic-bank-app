import 'dart:io';

import 'package:basic_banking/helpers/db.helpers.dart';
import 'package:basic_banking/models/customer.dart';
import 'package:flutter/cupertino.dart';

class Customers extends ChangeNotifier {
  // ignore: prefer_final_fields

  List<Customer> _customers = [];
  List<Customer> get getCustomers {
    return [..._customers];
  }

  void insertCustomer(File? image) {
    if (image == null) {
      print("null image");
      return;
    }

    final newCustomer = Customer(
        id: 000,
        name: "Ahmed Samir",
        email: "ahmedSamir@gmail.com",
        currentBalance: 10000,
        image: image);
    _customers.add(newCustomer);
    notifyListeners();

    DBHelper.insert("customer", {
      "name": newCustomer.name,
      "email": newCustomer.email,
      "balance": newCustomer.currentBalance,
      "image": newCustomer.image!.path,
    });
  }

  Future<void> fetchAndSetCustomers() async {
    final allData = await DBHelper.getData("customer");
    print(allData);
    _customers = allData.map((customer) {
      return Customer(
          id: customer["id"],
          name: customer["name"],
          email: customer["email"],
          currentBalance: customer["balance"],
          image: File(customer["image"]));
    }).toList();

    notifyListeners();
  }
}
