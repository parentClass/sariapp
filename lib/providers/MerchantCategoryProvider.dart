import 'package:flutter/widgets.dart';
import 'package:sariapp/models/MerchantCategory.dart';
import 'package:sariapp/models/ProductCategory.dart';

class MerchantCategoryProvider extends ChangeNotifier {
  List<MerchantCategory> _merchantCategoryList = [];

  /// Getters
  List<MerchantCategory> get merchantCategoryList => _merchantCategoryList;

  /// Setters
  setMerchantCategoryList(List<MerchantCategory> merchantCategoryList) {
    _merchantCategoryList.clear();
    _merchantCategoryList.addAll(merchantCategoryList);
    notifyListeners();
  }
}
