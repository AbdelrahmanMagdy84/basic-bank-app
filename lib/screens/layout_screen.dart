import 'package:basic_banking/screens/acounts_list_screen.dart';
import 'package:basic_banking/screens/transfers_screen.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
import 'package:flutter/material.dart';

class LayoutScreen extends StatelessWidget {
  static const routeName = "/layoutScreen";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
     
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: GradientWidget.linearGradientBuilder(context),
            ),
          ),
          centerTitle: true,
          title: GradientWidget(
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Basic Bank",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
                const SizedBox(
                  width: 10,
                ),
                Hero(
                  tag: "bank icon",
                  child: Icon(
                    Icons.account_balance_sharp,
                    color: Theme.of(context).colorScheme.onPrimary,
                    size: 35,
                  ),
                )
              ],
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
                text: "Acounts",
              ),
              Tab(
                icon: Icon(Icons.transfer_within_a_station_sharp),
                text: "Transfers",
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: TabBarView(children: [
            CustomersListScreen(),
            TransfersScreen(),
          ]),
        ),
      ),
    );
  }
}
