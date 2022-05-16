import 'package:basic_banking/Cubit/new_transaction/new_transaction_cubit.dart';
import 'package:basic_banking/models/Acount.dart';
import 'package:basic_banking/widgets/acount_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/acounts/acounts_cubit.dart';
import '../Cubit/acounts/acounts_states.dart';
import '../widgets/gradient_color_widget.dart';

class CustomersListScreen extends StatefulWidget {
  static const String routeName = "/customers' List screen";
  @override
  State<CustomersListScreen> createState() => _CustomersListScreenState();
}

class _CustomersListScreenState extends State<CustomersListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NewTransactionCubit.getObj(context).inProcess()
            ? AppBar(
                title: GradientWidget(
                  Text(
                    "Select the receiving acount",
                    maxLines: 2,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              )
            : null,
        body: FutureBuilder(
          future: AcountCubit.getObj(context).fetchAndSetacounts(),
          builder: (ctx, snap) {
            if (!mounted)
              return Container(
                color: Colors.black,
              );

            if (snap.connectionState == ConnectionState.waiting) {
              return GradientWidget(
                const Scaffold(
                  body: Center(
                    child: Text(
                      "Loading",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              );
            }
            return BlocBuilder<AcountCubit, AcountsStates>(
              builder: (BuildContext context, state) {
                List<Acount> acounts = [];
                if (NewTransactionCubit.getObj(context).inProcess()) {
                  acounts = AcountCubit.getObj(context).getAcountsExcept(
                      NewTransactionCubit.getObj(context).getSenderID);
                } else if (state is FetchAcountsState) {
                  acounts = state.acounts;
                }
                return ListView.builder(
                  itemCount: acounts.length,
                  itemBuilder: (context, index) {
                    return AcountCard(
                      acounts[index],
                    );
                  },
                );
              },
            );
          },
        ));
  }
}
