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

  List<BottomNavigationBarItem> _buildUpBottomNavItems(context) {
    List<BottomNavigationBarItem> items = [];

    // add home
    items.add(const BottomNavigationBarItem(label: "Home", icon: Icon(LineIcons.home)));
    
    // add store
    if(MerchantService.getProviderActiveMerchant(context).id != "") {
      items.add(const BottomNavigationBarItem(label: "Store", icon: Icon(LineIcons.store)));
    }

    // add cashier
    items.add(const BottomNavigationBarItem(label: "Cashier", icon: Icon(LineIcons.wallet)));

    // add feature
    items.add(const BottomNavigationBarItem(label: "Menu", icon: Icon(LineIcons.bars)));

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
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: HexColor(kGunmetalColor),
            selectedItemColor: HexColor(kGoldWebColor),
            unselectedItemColor: HexColor(kSariWhiteColor),
            items: _buildUpBottomNavItems(context),
            currentIndex: Provider.of<RoutingNav>(context).pageIndex,
            onTap: (index) => Helper.changeScreen(context, index)),
        extendBody: true,
        resizeToAvoidBottomInset: false,
      ),
    );
  }
}
