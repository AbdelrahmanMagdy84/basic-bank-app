import 'package:basic_banking/Cubit/acounts/acounts_cubit.dart';
import 'package:basic_banking/Cubit/acounts/acounts_states.dart';
import 'package:basic_banking/widgets/gradient_color_widget.dart';
import 'package:basic_banking/widgets/transfer_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AcountDetailsScreen extends StatelessWidget {
  int targetedAcountId;
  AcountDetailsScreen(this.targetedAcountId);
  static const String routeName = "/customer details screen";

  FittedBox textBuilder(String title, String value) {
    return FittedBox(
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientWidget(Text(
          "Acount Details",
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
        )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: GradientWidget.linearGradientBuilder(context)),
        child:
            BlocBuilder<AcountCubit, AcountsStates>(builder: (context, state) {
          if (state is FetchAcountsState) {
            final currentAcount =
                AcountCubit.getObj(context).getAcountByID(targetedAcountId);
            return SingleChildScrollView(
              child: Column(children: [
                const SizedBox(
                  height: 40,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: currentAcount.id,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(
                        currentAcount.image!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: textBuilder("Name: ", currentAcount.name),
                      ),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: textBuilder("Email: ", currentAcount.email),
                      ),
                      const Divider(),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: textBuilder(
                            "Balance: ", "\$${currentAcount.currentBalance}"),
                      ),
                    ],
                  ),
                ),
                TransferInputWidget(
                    currentAcount.id, currentAcount.currentBalance)
              ]),
            );
          }
          return Center(child: Text("Loading"),);
        }),
      ),
    );
  }
}
