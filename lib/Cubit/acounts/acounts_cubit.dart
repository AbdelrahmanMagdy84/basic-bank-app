
import 'dart:io';
import 'package:basic_banking/Cubit/acounts/acounts_states.dart';
import 'package:basic_banking/helpers/db.helpers.dart';
import 'package:basic_banking/models/Acount.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AcountCubit extends Cubit<AcountsStates>{
AcountCubit() : super(InitAcountState());
List<Acount> _acounts = [];

static AcountCubit getObj(BuildContext ctx){
  return BlocProvider.of<AcountCubit>(ctx);
}
  List<Acount> get getacounts {
    return [..._acounts];
  }
   void createDatabase()async{
    await DBHelper.database();
    emit(CreateDatabaseState());
  }
   Future<void> fetchAndSetacounts() async {
     print("fetchAndSetacounts");
    final allData = await DBHelper.getData("customer");
    _acounts = allData.map((customer) {
      return Acount(
          id: customer["id"],
          name: customer["name"],
          email: customer["email"],
          currentBalance: customer["balance"],
          image: File(customer["image"]));
    }).toList();

    emit(FetchAcountsState(getacounts));
  }
 

  List<Acount> get getAcounts {
    return [..._acounts];
  }

  List<Acount> getAcountsExcept(int id) {
    final copyList = [..._acounts];
    copyList.removeWhere((element) {
      return element.id == id;
    });
    return copyList;
  }

  Acount getAcountByID(int id) {
    return _acounts.firstWhere((element) {
      return element.id == id;
    });
  }
  @override
  void onChange(Change<AcountsStates> change) {
    // TODO: implement onChange
    super.onChange(change);
    print(change);
  }
    Future<void> updateCustomersBalance(int senderId, double senderBalance,
      int receiverId, double receiverBalance, amount) async {
    double newSenderBalance = senderBalance - amount;
    double newReceiverBalance = receiverBalance + amount;
    await DBHelper.update(
        senderId, newSenderBalance, receiverId, newReceiverBalance);
    await fetchAndSetacounts();
  }
}