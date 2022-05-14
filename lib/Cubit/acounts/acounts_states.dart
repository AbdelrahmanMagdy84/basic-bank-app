import 'package:basic_banking/models/Acount.dart';

abstract class AcountsStates{}
class InitAcountState extends AcountsStates{}
class CreateDatabaseState extends AcountsStates{}
class FetchAcountsState extends AcountsStates{
  List<Acount> acounts = [];
  FetchAcountsState(this.acounts);
}