import 'package:provider/provider.dart';
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/providers/MerchantProvider.dart';

class MerchantService {
  static List<Merchant> getProviderMerchantList(context) {
    return Provider.of<MerchantProvider>(context).merchantList;
  }

  static void setProviderActiveMerchant(context, Merchant merchant) {
    Provider.of<MerchantProvider>(context, listen: false)
        .setActiveMerchant(merchant);
  }

  static Merchant getProviderActiveMerchant(context) {
    return Provider.of<MerchantProvider>(context).activeMerchant;
  }

  static void setProviderMerchantList(context, List<Merchant> merchants) {
    Provider.of<MerchantProvider>(context, listen: false)
        .clearMerchantList();
    Provider.of<MerchantProvider>(context, listen: false)
        .setMerchantList(merchants);
  }
}
