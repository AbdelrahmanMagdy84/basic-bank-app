import 'package:basic_banking/screens/customers_list_screen.dart';
import 'package:basic_banking/screens/transfers_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Basic Bank",
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.account_balance_outlined),
                text: "Acounts",
              ),
              Tab(
                icon: Icon(Icons.transfer_within_a_station),
                text: "Transfers",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          CustomersListScreen(),
          TransfersScreen(),
        ]),
      ),
    );
  }
}
