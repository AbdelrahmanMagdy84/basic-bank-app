import 'dart:io';

class Acount {
  int id;
  String name;
  String email;
  double currentBalance = 0.0;
  File? image;
  Acount(
      {required this.id,
      required this.name,
      required this.email,
      required this.currentBalance,
      required this.image});
  double increaseCopyOfBalance(double incAmount) {
    return currentBalance + incAmount;
  }
}
