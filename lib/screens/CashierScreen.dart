import 'package:flutter/widgets.dart';

class CashierScreen extends StatefulWidget {
  const CashierScreen({Key? key}) : super(key: key);

  // Screen id
  static const String id = "CashierScreen";

  @override
  State<CashierScreen> createState() => _CashierScreenState();
}

class _CashierScreenState extends State<CashierScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Cashier"));
  }
}
