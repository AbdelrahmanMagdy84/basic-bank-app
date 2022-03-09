import 'package:basic_banking/screens/customers_list_screen.dart';
import 'package:flutter/material.dart';

class TransferInputWidget extends StatefulWidget {
  final double balance;
  final int sender_id;
  TransferInputWidget(this.sender_id, this.balance);
  @override
  _TransferInputWidgetState createState() => _TransferInputWidgetState();
}

class _TransferInputWidgetState extends State<TransferInputWidget>
    with SingleTickerProviderStateMixin {
  bool showInputWidget = false;
  final amountController = TextEditingController();
  String? error;

  late AnimationController _animationController;
  late Animation<Offset> _positionAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, -1), end: const Offset(0, 0))
            .animate(CurvedAnimation(
                parent: _animationController, curve: Curves.easeInOutBack));
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack));
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  bool _validate() {
    if (amountController.text.isEmpty) {
      setState(() {
        error = "can't be empty";
      });
      return false;
    }
    if (int.parse(amountController.text) > widget.balance) {
      print(int.parse(amountController.text));
      print(widget.balance);
      setState(() {
        error = "can't be greater than balance";
      });
      return false;
    }
    error = null;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            onPressed: () {
              setState(() {
                showInputWidget = !showInputWidget;
                if (showInputWidget == true) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
              });
            },
            child: const Text("Transfer money"),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                  position: _positionAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            controller: amountController,
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              errorText: error,
                              errorMaxLines: 2,
                              labelStyle: const TextStyle(
                                fontSize: 16,
                              ),
                              label: Container(
                                alignment: Alignment.center,
                                child: const Text("Amount to transfer"),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton.icon(
                            label: const Text("Transfer To"),
                            icon: const Icon(Icons.person),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_validate()) {
                                Navigator.pushNamed(
                                    context, CustomersListScreen.routeName,
                                    arguments: {
                                      "senderId": widget.sender_id,
                                      "amount":
                                          double.parse(amountController.text)
                                    });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
