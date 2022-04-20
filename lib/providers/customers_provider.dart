import 'dart:io';
import 'package:basic_banking/helpers/db.helpers.dart';
import 'package:basic_banking/models/customer.dart';
import 'package:flutter/material.dart';

class Customers extends ChangeNotifier {
  // ignore: prefer_final_fields

  List<Customer> _customers = [];
  List<Customer> get getCustomers {
    return [..._customers];
  }

  List<Customer> getCustomersExcept(int id) {
    final copyList = [..._customers];
    copyList.removeWhere((element) {
      return element.id == id;
    });
    return copyList;
  }

  Customer getCustomerByID(int id) {
    return _customers.firstWhere((element) {
      return element.id == id;
    });
  }

  // void insertCustomer(File? image) {
  //   if (image == null) {
  //     print("null image");
  //     return;
  //   }

  //   final newCustomer = Customer(
  //       id: 000,
  //       name: "Magdy Hassan",
  //       email: "MohamedAhmed@gmail.com",
  //       currentBalance: 7840.5,
  //       image: image);
  //   _customers.add(newCustomer);
  //   notifyListeners();

  //   DBHelper.insert("customer", {
  //     "name": newCustomer.name,
  //     "email": newCustomer.email,
  //     "balance": newCustomer.currentBalance,
  //     "image": newCustomer.image!.path,
  //   });
  // }

  Future<void> fetchAndSetCustomers() async {
    final allData = await DBHelper.getData("customer");
    

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

  Future<void> updateCustomersBalance(int senderId, double senderBalance,
      int receiverId, double receiverBalance, amount) async {
    double newSenderBalance = senderBalance - amount;
    double newReceiverBalance = receiverBalance + amount;
    await DBHelper.update(
        senderId, newSenderBalance, receiverId, newReceiverBalance);
    fetchAndSetCustomers();
  }
}
