import 'package:provider/provider.dart';
import 'package:sariapp/models/ProductCategory.dart';
import 'package:sariapp/providers/MerchantCategoryProvider.dart';
import 'package:sariapp/providers/ProductCategoryProvider.dart';

import '../models/MerchantCategory.dart';

class MerchantCategoryService {
  static List<MerchantCategory> getMerchantCategoryList(context) {
    return Provider.of<MerchantCategoryProvider>(context).merchantCategoryList;
  }

  static void setProviderMerchantCategoryList(context, List<MerchantCategory> merchantCategories) {
    Provider.of<MerchantCategoryProvider>(context, listen: false)
        .setMerchantCategoryList(merchantCategories);
  }
}
