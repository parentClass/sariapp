import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icon.dart';
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/screens/SearchScreen.dart';
import 'package:sariapp/screens/StoreScreen.dart';
import 'package:sariapp/services/ApiService.dart';
import 'package:sariapp/services/MerchantService.dart';
import 'package:sariapp/services/RoutingService.dart';
import 'package:sariapp/utils/Constants.dart';
import 'package:sariapp/utils/Extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  // Screen id
  static const String id = "HomeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchTextFieldController;

  List<Merchant> _merchantList = [];

  Widget _buildUpSearchBar() {
    return Center(
      child: Wrap(
        runSpacing: 10.0,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 15.0),
            child: Text("Search for a store",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22.0)),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: 57.0,
            child: TextField(
              controller: _searchTextFieldController,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.black),
                    borderRadius: BorderRadius.circular(30),
                  )),
              onSubmitted: (search) => _searchStore(search),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUpNearbyStores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nearby stores",
            style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 15.0),
        ConstrainedBox(
          constraints: BoxConstraints.loose(
              Size(MediaQuery.of(context).size.width, 120.0)),
          child: Swiper(
            outer: false,
            loop: false,
            viewportFraction: 0.85,
            scale: 0.9,
            itemBuilder: (c, index) {
              return Card(
                  elevation: 5.0,
                  color: HexColor(kGunmetalColor),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                              "${_merchantList.elementAt(index).merchant_name.toTitleCase()} - ${_merchantList.elementAt(index).merchant_type.name.toTitleCase()}",
                              style: TextStyle(color: HexColor(kGoldWebColor))),
                          Text(
                              _merchantList
                                  .elementAt(index)
                                  .merchant_address
                                  .toTitleCase(),
                              style: TextStyle(color: HexColor(kGoldWebColor)))
                        ],
                      ),
                    ),
                  ));
            },
            itemCount: _merchantList.length,
          ),
        )
      ],
    );
  }

  Widget _buildUpPromotedStores() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Top stores", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 15.0),
        ConstrainedBox(
          constraints: BoxConstraints.loose(
              Size(MediaQuery.of(context).size.width, 120.0)),
          child: Swiper(
            outer: false,
            loop: false,
            scale: 0.9,
            itemBuilder: (c, index) {
              return GestureDetector(
                child: Card(
                    elevation: 5.0,
                    color: HexColor(kGunmetalColor),
                    child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LineIcon.star(
                              color: HexColor(kSpringGreenColor),
                              size: 12.0,
                            ),
                            Wrap(
                              direction: Axis.vertical,
                              children: [
                                Text(
                                    "${_merchantList.elementAt(index).merchant_name.toTitleCase()} - ${_merchantList.elementAt(index).merchant_type.name.toTitleCase()}",
                                    style: TextStyle(
                                        color: HexColor(kGoldWebColor))),
                                Text(
                                    _merchantList
                                        .elementAt(index)
                                        .merchant_address
                                        .toTitleCase(),
                                    style: TextStyle(
                                        color: HexColor(kGoldWebColor)))
                              ],
                            ),
                          ],
                        ))),
                onTap: () {
                  ApiService.getMerchantById(
                      context, _merchantList.elementAt(index).id);
                  RoutingService.pushScreen(context,
                      StoreScreen(storeId: _merchantList.elementAt(index).id));
                },
              );
            },
            itemCount: _merchantList.length,
          ),
        )
      ],
    );
  }

  Widget _buildUpStoreCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Categories", style: TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 15.0),
        ConstrainedBox(
            constraints: BoxConstraints.loose(
                Size(MediaQuery.of(context).size.width, 120.0)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(children: const [
                    Text("category# 1"),
                    Text("category# 2"),
                    Text("category# 3"),
                    Text("category# 4"),
                    Text("category# 5")
                  ]),
                  Column(children: const [
                    Text("category# 6"),
                    Text("category# 7"),
                    Text("category# 8"),
                    Text("category# 9"),
                    Text("category# 10")
                  ])
                ]))
      ],
    );
  }

  void _searchStore(search) {
    RoutingService.pushScreen(context, SearchScreen(search: search));
  }

  @override
  void initState() {
    super.initState();

    _searchTextFieldController = TextEditingController(text: "");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // api calls
      ApiService.getMerchantList(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _merchantList = MerchantService.getProviderMerchantList(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 35.0, bottom: 85.0),
              child: Wrap(
                runSpacing: 10.0,
                children: [
                  _buildUpSearchBar(),
                  _buildUpPromotedStores(),
                  _buildUpStoreCategories(),
                  _buildUpNearbyStores()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
