import 'package:basic_banking/screens/layout_screen.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import '../providers/customers_provider.dart';
import '../providers/transactions_provider.dart';

class SplashScreen extends StatefulWidget {
  String text;
  IconData icon;

  SplashScreen(this.text, this.icon);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late double size;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.icon == Icons.account_balance_sharp) {
      size = 60;
      Provider.of<Customers>(context, listen: false).fetchAndSetCustomers();
      Provider.of<TransactionsProvider>(context, listen: false)
          .fetchAndSetData();
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(seconds: 1),
            pageBuilder: (_, __, ___) => LayoutScreen(),
          ),
        );
      });
    } else {
      size = 30;
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: GradientWidget.linearGradientBuilder(context, opacity: 1),
      ),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.withOpacity(0.1),
        body: Container(
          child: SplashTitleWidget(size, widget.text, widget.icon),
          margin: const EdgeInsets.only(left: 10),
        ),
      ),
    );
  }
}

class SplashTitleWidget extends StatelessWidget {
  final double? size;
  String text;
  IconData icon;

  // ignore: use_key_in_widget_constructors
  SplashTitleWidget(this.size, this.text, this.icon);
  Widget textBuilder(String text, BuildContext ctx) {
    return Text(
      text,
      style: TextStyle(color: Theme.of(ctx).colorScheme.onPrimary).copyWith(
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GradientWidget(textBuilder(text, context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientWidget(
              Hero(
                tag: icon == Icons.account_balance_sharp ? "bank icon" : "null",
                child: Icon(
                  icon,
                  color: Theme.of(context).colorScheme.onPrimary,
                  size: size! * 4,
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
