import 'package:provider/provider.dart';
import 'package:sariapp/models/Product.dart';
import 'package:sariapp/providers/ProductProvider.dart';

class ProductService {
  static List<Product> getProductList(context) {
    return Provider.of<ProductProvider>(context).productList;
  }

  static void setProviderProductList(context, List<Product> productList) {
    Provider.of<ProductProvider>(context, listen: false)
        .setProductList(productList);
  }
}
