import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:line_icons/line_icons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/models/Product.dart';
import 'package:sariapp/models/ProductCategory.dart';
import 'package:sariapp/models/ProductSubcategory.dart';
import 'package:sariapp/providers/ProductCategoryProvider.dart';
import 'package:sariapp/screens/StoreInfoScreen.dart';
import 'package:sariapp/services/ApiService.dart';
import 'package:sariapp/services/MerchantService.dart';
import 'package:sariapp/services/ProductCategoryService.dart';
import 'package:sariapp/services/ProductService.dart';
import 'package:sariapp/services/ProductSubcategoryService.dart';
import 'package:sariapp/utils/Constants.dart';

class StoreScreen extends StatefulWidget {
  final String storeId;

  const StoreScreen({Key? key, required this.storeId}) : super(key: key);

  // Screen id
  static const String id = "StoreScreen";

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  int currentSelectedCategory = 0;
  int currentSelectedSubCategory = 9999;
  List<Product> productList = [];
  List<Product> filteredProductList = [];
  List<ProductCategory> categoryList = [];
  List<ProductSubcategory> subcategoryList = [];
  List<ProductSubcategory> filteredSubcategoryList = [];

  late Merchant activeMerchant;

  Widget _buildUpCategoryCards() {
    List<String> categoryChipList = [];

    if (categoryList.isNotEmpty) {
      categoryChipList.add("All");
      categoryChipList.addAll(categoryList.map((e) => e.label).toList());
    }

    return Padding(
        padding: const EdgeInsets.only(
            top: 15.0, bottom: 5.0, left: 10.0, right: 10.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text("Categories"),
          (categoryList.isNotEmpty)
              ? ChipList(
                  listOfChipNames: categoryChipList,
                  activeBgColorList: [HexColor(kGoldWebColor)],
                  inactiveBgColorList: const [Colors.transparent],
                  activeTextColorList: [HexColor(kGunmetalColor)],
                  inactiveTextColorList: [HexColor(kGunmetalColor)],
                  listOfChipIndicesCurrentlySeclected: [
                    currentSelectedCategory
                  ],
                  inactiveBorderColorList: const [Colors.transparent],
                  extraOnToggle: (val) => _onCategorySelect(val),
                  style: const TextStyle(fontWeight: FontWeight.bold))
              : const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Loading...."),
                )
        ]));
  }

  Widget _buildUpSubcategoryCards() {
    // add all entry for default
    List<String> subCategoryChipList = [];

    if (currentSelectedCategory == 0) {
      subCategoryChipList.addAll(subcategoryList.map((e) => e.label).toList());
    } else {
      subCategoryChipList.addAll(filteredSubcategoryList.map((e) => e.label).toList());
    }

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          const Text("Sub-categories"),
          (subcategoryList.isNotEmpty)
              ? ChipList(
                  listOfChipNames: (currentSelectedCategory != 0)
                      ? filteredSubcategoryList.map((e) => e.label).toList()
                      : subCategoryChipList,
                  activeBgColorList: [HexColor(kGoldWebColor)],
                  inactiveBgColorList: const [Colors.transparent],
                  activeTextColorList: [HexColor(kGunmetalColor)],
                  inactiveTextColorList: [HexColor(kGunmetalColor)],
                  listOfChipIndicesCurrentlySeclected: [
                    currentSelectedSubCategory
                  ],
                  inactiveBorderColorList: const [Colors.transparent],
                  extraOnToggle: (val) => _onSubCategorySelect(val),
                  style: const TextStyle(fontWeight: FontWeight.bold))
              : const Center(
                  child: Text("No Subcategories"),
                )
        ]));
  }

  Widget _buildUpProductList() {
    List<Widget> products = [];

    // sort inventory alphabetically
    filteredProductList.sort((a, b) => a.label.compareTo(b.label));

    if (currentSelectedCategory == 0 && currentSelectedSubCategory == 9999) {
      // get products from product list if selected category is all
      for (var product in productList) {
        products.add(ListTile(title: Text(product.label)));
      }
    } else {
      // get products from filtered product list if there's a selected category
      for (var product in filteredProductList) {
        products.add(ListTile(title: Text(product.label)));
      }
    }

    return Expanded(
        child: Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: ListView(
        children: products,
      ),
    ));
  }

  _onCategorySelect(int val) {
    var categoryEl = ProductCategory(
        id: "",
        label: "All",
        merchant_id: "",
        sub_categories: [],
        created_time: "",
        modified_time: "",
        deleted_time: "",
        is_deleted: false,
        is_activated: true);

    // -1 to remove all, since its not included in the original category list
    if (val != 0) categoryEl = categoryList.elementAt(val - 1);

    setState(() {
      currentSelectedCategory = val;
      // set selected category
      Provider.of<ProductCategoryProvider>(context, listen: false)
          .setActiveCategory(categoryEl);

      // set sub categories to all if first chip selected
      if (val > 0) {
        _setFilteredSubCategoryState(subcategoryList
            .where((element) => categoryEl.sub_categories.contains(element.id))
            .toList());
      } else {
        _setFilteredSubCategoryState(subcategoryList);
      }

      // to remove currently selected sub category
      currentSelectedSubCategory = 9999;

      // add all product list
      _setFilteredProductState(productList
          .where((element) => element.categories.contains(categoryEl.id))
          .toList());
    });
  }

  _onSubCategorySelect(int val) {
    setState(() {
      // set current selected sub category
      currentSelectedSubCategory = val;

      if (currentSelectedCategory != 0) {
        // filter product list by subcategory id and category id
        _setFilteredProductState(productList
            .where((element) =>
                element.sub_categories
                    .contains(filteredSubcategoryList.elementAt(val).id) &&
                element.categories.contains(
                    categoryList.elementAt(currentSelectedCategory - 1).id))
            .toList());
      } else {
        // filter product list by subcategory id
        _setFilteredProductState(productList
            .where((element) => element.sub_categories
                .contains(subcategoryList.elementAt(val).id))
            .toList());
      }
    });
  }

  _setFilteredSubCategoryState(List<ProductSubcategory> subCategoryList) {
    setState(() {
      filteredSubcategoryList.clear();
      filteredSubcategoryList.addAll(subCategoryList);
    });
  }

  _setFilteredProductState(List<Product> products) {
    setState(() {
      filteredProductList.clear();
      filteredProductList.addAll(products);
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // api calls
      ApiService.getCategoryList(context);
      ApiService.getSubCategoryList(context);
      ApiService.getProductList(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    activeMerchant = MerchantService.getProviderMerchantList(context)
        .where((element) => element.id == widget.storeId)
        .first;
    productList = ProductService.getProductList(context)
        .where((element) => element.merchant_id == widget.storeId)
        .toList();
    categoryList = ProductCategoryService.getCategoryList(context)
        .where((element) => element.merchant_id == widget.storeId)
        .toList();
    subcategoryList = ProductSubcategoryService.getSubcategoryList(context)
        .where((element) => element.merchant_id == widget.storeId)
        .toList();
    filteredSubcategoryList =
        ProductSubcategoryService.getFilteredSubcategoryList(context)
            .where((element) => element.merchant_id == widget.storeId)
            .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                icon: const Icon(LineIcons.arrowLeft),
                onPressed: () => Navigator.pop(context)),
            title:
                Text(activeMerchant.merchant_name, overflow: TextOverflow.fade),
            actions: [
              const Tooltip(
                  message: "Store is currently closed",
                  child:
                      Icon(LineIcons.exclamationTriangle, color: Colors.red)),
              Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                  child: IconButton(
                      onPressed: () => Navigator.push(
                          context,
                          PageTransition(
                              child: const StoreInfoScreen(),
                              type: PageTransitionType.bottomToTop)),
                      icon: const Icon(
                        LineIcons.infoCircle,
                        color: Colors.white,
                      )))
            ],
            backgroundColor: HexColor(kGunmetalColor)),
        body: Column(children: [
          _buildUpCategoryCards(),
          _buildUpSubcategoryCards(),
          _buildUpProductList()
        ]));
  }
}
