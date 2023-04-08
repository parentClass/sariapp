import 'package:provider/provider.dart';
import 'package:sariapp/models/ProductCategory.dart';
import 'package:sariapp/providers/ProductCategoryProvider.dart';

class ProductCategoryService {
  static List<ProductCategory> getCategoryList(context) {
    return Provider.of<ProductCategoryProvider>(context).categoryList;
  }

  static void setProviderCategoryList(context, List<ProductCategory> categories) {
    Provider.of<ProductCategoryProvider>(context, listen: false)
        .setCategoryList(categories);
  }
}
