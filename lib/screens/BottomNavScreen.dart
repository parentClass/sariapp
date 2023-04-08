import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:sariapp/providers/RoutingNav.dart';
import 'package:sariapp/services/MerchantService.dart';
import 'package:sariapp/services/RoutingService.dart';
import 'package:sariapp/utils/Constants.dart';
import 'package:sariapp/utils/Helper.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  /// Iterator for the tabs
  late PageController _pageController;

  List<DotNavigationBarItem> _buildUpBottomNavItems(context) {
    List<DotNavigationBarItem> items = [];

    // add home
    items.add(DotNavigationBarItem(icon: const Icon(LineIcons.home)));
    
    // add store
    if(MerchantService.getProviderActiveMerchant(context).id != "") {
      items.add(DotNavigationBarItem(icon: const Icon(LineIcons.store)));
    }

    // add cashier
    items.add(DotNavigationBarItem(icon: const Icon(LineIcons.cashRegister)));

    // add feature
    items.add(DotNavigationBarItem(icon: const Icon(LineIcons.bars)));

    return items;
  }
  
  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
            controller: Provider.of<RoutingNav>(context).pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: RoutingService(context: context).bottomRouteList),
        bottomNavigationBar: DotNavigationBar(
            backgroundColor: HexColor(kGunmetalColor),
            selectedItemColor: HexColor(kGoldWebColor),
            unselectedItemColor: HexColor(kSariWhiteColor),
            enablePaddingAnimation: false,
            enableFloatingNavBar: true,
            paddingR: const EdgeInsets.all(10.0),
            items: _buildUpBottomNavItems(context),
            currentIndex: Provider.of<RoutingNav>(context).pageIndex,
            onTap: (index) => Helper.changeScreen(context, index)),
        extendBody: true,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
