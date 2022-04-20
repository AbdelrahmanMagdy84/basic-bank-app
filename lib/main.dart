import 'package:basic_banking/providers/customers_provider.dart';
import 'package:basic_banking/providers/new_transaction_data_provider.dart';
import 'package:basic_banking/providers/transactions_provider.dart';
import 'package:basic_banking/screens/customers_list_screen.dart';
import 'package:basic_banking/screens/layout_screen.dart';
import 'package:basic_banking/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData();
  Color myHexColor = Color(0xff123456);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
              primary: Colors.blueGrey,
              secondary: Colors.pink[100],
              onPrimary: Colors.pink[900]),
          tabBarTheme: const TabBarTheme().copyWith(
            labelColor: Colors.pink[900],
          ),
        ),
        routes: {
          "/": (ctx) => SplashScreen("Basic Bank", Icons.account_balance_sharp),
          CustomersListScreen.routeName: (ctx) => CustomersListScreen(),
          LayoutScreen.routeName: (ctx) => LayoutScreen(),
          // CustomerDetailsScreen.routeName: (ctx) => CustomerDetailsScreen()
        },
      ),
      providers: [
        ChangeNotifierProvider.value(
          value: Customers(),
        ),
        ChangeNotifierProvider.value(
          value: TransactionsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewTransactionDataProvider(),
        )
      ],
    );
  }
}
