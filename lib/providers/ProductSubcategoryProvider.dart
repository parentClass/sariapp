import 'package:flutter/widgets.dart';
import 'package:sariapp/models/ProductSubcategory.dart';

class ProductSubcategoryProvider extends ChangeNotifier {
  List<ProductSubcategory> _subcategoryList = [];
  List<ProductSubcategory> _filteredSubCategory = [];

  /// Getters
  List<ProductSubcategory> get subcategoryList => _subcategoryList;

  List<ProductSubcategory> get filteredSubcategoryList => _filteredSubCategory;

  /// Setters
  setSubcategoryList(List<ProductSubcategory> subcategoryList) {
    _subcategoryList.clear();
    _subcategoryList.addAll(subcategoryList);
    notifyListeners();
  }

  setFilteredSubcategoryList(List<ProductSubcategory> filteredSubcategoryList) {
    _filteredSubCategory.clear();
    _filteredSubCategory.addAll(filteredSubcategoryList);
    notifyListeners();
  }
}
