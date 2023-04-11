import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sariapp/providers/MerchantCategoryProvider.dart';
import 'package:sariapp/providers/ProductCategoryProvider.dart';
import 'package:sariapp/providers/MerchantProvider.dart';
import 'package:sariapp/providers/ProductProvider.dart';
import 'package:sariapp/providers/RoutingNav.dart';
import 'package:sariapp/providers/ProductSubcategoryProvider.dart';
import 'package:sariapp/screens/BottomNavScreen.dart';
import 'package:sariapp/utils/Constants.dart';

void main() {
  runApp(const SariSariApp());
}

class SariSariApp extends StatelessWidget {
  const SariSariApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RoutingNav>(create: (_) => RoutingNav()),
        ChangeNotifierProvider<MerchantProvider>(create: (_) => MerchantProvider()),
        ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
        ChangeNotifierProvider<ProductCategoryProvider>(create: (_) => ProductCategoryProvider()),
        ChangeNotifierProvider<ProductSubcategoryProvider>(create: (_) => ProductSubcategoryProvider()),
        ChangeNotifierProvider<MerchantCategoryProvider>(create: (_) => MerchantCategoryProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppTitle,
        home: const BottomNavScreen(),
        builder: EasyLoading.init(),
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
