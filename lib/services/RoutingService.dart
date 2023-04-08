import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sariapp/screens/CashierScreen.dart';
import 'package:sariapp/screens/FeatureScreen.dart';
import 'package:sariapp/screens/HomeScreen.dart';
import 'package:sariapp/screens/StoreScreen.dart';
import 'package:sariapp/services/MerchantService.dart';

class RoutingService {
  // Constructor
  RoutingService({required this.context});

  // Properties
  BuildContext context;

  /// Retrieve route list for bottom nav type navigation
  /// Screens listed should be in strict order, since it depends on screen list indexing
  List<Widget> get bottomRouteList {
    // Routes
    return [
      const HomeScreen(),
      // only include store if there's an active merchant
      if (MerchantService.getProviderActiveMerchant(context).id != "")
        StoreScreen(
            storeId: MerchantService.getProviderActiveMerchant(context).id),
      const CashierScreen(),
      const FeatureScreen()
    ];
  }

  static void pushScreen(context, Widget screen) {
    Navigator.push(context,
        PageTransition(child: screen, type: PageTransitionType.bottomToTop));
  }
}
