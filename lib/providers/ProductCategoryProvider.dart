import 'package:flutter/widgets.dart';
import 'package:sariapp/models/ProductCategory.dart';

class ProductCategoryProvider extends ChangeNotifier {
  List<ProductCategory> _categoryList = [];
  late ProductCategory _activatedCategory;

  /// Getters
  List<ProductCategory> get categoryList => _categoryList;

  /// Setters
  setCategoryList(List<ProductCategory> categoryList) {
    _categoryList.clear();
    _categoryList.addAll(categoryList);
    notifyListeners();
  }

  setActiveCategory(ProductCategory category) {
    _activatedCategory = category;
    notifyListeners();
  }
}
