import 'dart:io';

class Customer {
  int id;
  String name;
  String email;
  double currentBalance = 0.0;
  File? image;
  Customer(
      {required this.id,
      required this.name,
      required this.email,
      required this.currentBalance,
      required this.image});
}
