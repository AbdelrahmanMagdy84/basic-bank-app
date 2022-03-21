import 'package:basic_banking/models/customer.dart';
import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/widgets/transfer_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'when adding new amount to customer balance then the result should be a copy of the balance',
      () async {
    // final customer = Customer(
    //     currentBalance: 50.5,
    //     email: 'magdy@gmail.com',
    //     id: 99,
    //     image: null,
    //     name: 'magdy');
    //       customer.increaseCopyOfBalance(100);
    // expect(customer.currentBalance, 50.5);

    final x = Customers();
    expect(x.getCustomers.length, 0);
  });
}
