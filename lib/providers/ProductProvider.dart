import 'package:flutter/widgets.dart';
import 'package:sariapp/models/Product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productList = [];

  /// Getters
  List<Product> get productList => _productList;

  /// Setters
  setProductList(List<Product> productList) {
    _productList.clear();
    _productList.addAll(productList);
    notifyListeners();
  }
}