import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/providers/transactions_provider.dart';
import 'package:basic_banking/screens/customers_list_screen.dart';
import 'package:basic_banking/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (ctx) => MainScreen(),
          CustomersListScreen.routeName: (ctx) => CustomersListScreen(),
          // CustomerDetailsScreen.routeName: (ctx) => CustomerDetailsScreen()
        },
      ),
      providers: [
        ChangeNotifierProvider.value(
          value: Customers(),
        ),
        ChangeNotifierProvider.value(
          value: TransactionsProvider(),
        )
      ],
    );
  }
}
