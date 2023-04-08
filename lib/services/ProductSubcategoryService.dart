import 'package:provider/provider.dart';
import 'package:sariapp/models/ProductSubcategory.dart';
import 'package:sariapp/providers/ProductSubcategoryProvider.dart';

class ProductSubcategoryService {
  static List<ProductSubcategory> getSubcategoryList(context) {
    return Provider.of<ProductSubcategoryProvider>(context).subcategoryList;
  }

  static List<ProductSubcategory> getFilteredSubcategoryList(context) {
    return Provider.of<ProductSubcategoryProvider>(context).filteredSubcategoryList;
  }

  static void setProviderSubcategoryList(
      context, List<ProductSubcategory> subcategories) {
    Provider.of<ProductSubcategoryProvider>(context, listen: false)
        .setSubcategoryList(subcategories);
  }
}
