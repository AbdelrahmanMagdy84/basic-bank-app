import 'package:basic_banking/Cubit/new_transaction/new_transaction_cubit.dart';
import 'package:basic_banking/Cubit/transactions/transactions_cubit.dart';

import 'package:basic_banking/screens/acounts_list_screen.dart';
import 'package:basic_banking/screens/layout_screen.dart';
import 'package:basic_banking/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Cubit/acounts/acounts_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final theme = ThemeData();
  Color myHexColor = const Color(0xff123456);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: theme.copyWith(
          colorScheme: theme.colorScheme.copyWith(
              primary: Colors.blueGrey,
              secondary: Colors.pink[100],
              onPrimary: Colors.pink[900]),
          tabBarTheme: const TabBarTheme().copyWith(
            labelColor: Colors.pink[900],
          ),
        ),
        home: SplashScreen("Basic Bank", Icons.account_balance_sharp),
        routes: {
          CustomersListScreen.routeName: (ctx) => CustomersListScreen(),
          LayoutScreen.routeName: (ctx) => LayoutScreen(),
        },
      ),
      providers: [
        BlocProvider(create: (context) => AcountCubit()),
        BlocProvider(create: (context) => TransactionsCubit()),
        BlocProvider(create: (context) => NewTransactionCubit()),
      ],
    );
  }
}
