import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/screens/StoreScreen.dart';
import 'package:sariapp/services/MerchantService.dart';
import 'package:sariapp/services/RoutingService.dart';
import 'package:sariapp/utils/Constants.dart';
import 'package:string_similarity/string_similarity.dart';

class SearchScreen extends StatefulWidget {
  final String search;

  const SearchScreen({Key? key, required this.search}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Merchant> _merchantList = [];

  List<Widget> _buildMerchantSearchTiles() {
    List<Widget> merchantSearchTiles = [];

    for (var merchant in _merchantList) {
      merchantSearchTiles.add(ListTile(
        title: Text(merchant.merchant_name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(merchant.merchant_address),
        onTap: () => _onMerchantSearchTap(context, merchant.id),
      ));
    }

    return merchantSearchTiles;
  }

  void _onMerchantSearchTap(context, String storeId) {
    // push to store screen
    RoutingService.pushScreen(context, StoreScreen(storeId: storeId));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    MerchantService.getProviderMerchantList(context).forEach((element) {
      if (element.merchant_name.similarityTo(widget.search) > 0.40) {
        _merchantList.add(element);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              icon: const Icon(LineIcons.arrowLeft),
              onPressed: () => Navigator.pop(context)),
          title: const Text("Search"),
          backgroundColor: HexColor(kGunmetalColor)),
      body: (_merchantList.isNotEmpty)
          ? SingleChildScrollView(
              child: Wrap(
              children: _buildMerchantSearchTiles(),
            ))
          : const Center(
              child: Text("No store found"),
            ),
    );
  }
}
