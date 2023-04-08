import 'package:flutter/widgets.dart';
import 'package:sariapp/models/MembershipType.dart';
import 'package:sariapp/models/Merchant.dart';
import 'package:sariapp/models/MerchantType.dart';

class MerchantProvider extends ChangeNotifier {
  List<Merchant> _merchantList = [];
  Merchant _activeMerchant = Merchant(
      id: "",
      account_id: "",
      owner_name: "",
      owner_address: "",
      owner_contact: "",
      merchant_name: "",
      merchant_contact: "",
      merchant_address: "",
      merchant_region: "",
      merchant_type: MerchantType.SARIOWNER,
      total_income: 0,
      average_income: 0,
      customer_count: 0,
      average_traffic: 0,
      total_visits: 0,
      sku_id: 0,
      membership_type: MembershipType.FREE,
      membership_start: "",
      membership_end: "",
      last_sync: "",
      created_time: "",
      modified_time: "",
      deleted_time: "",
      is_deleted: false,
      is_activated: false);

  /// Getters
  List<Merchant> get merchantList => _merchantList;

  Merchant get activeMerchant => _activeMerchant;

  /// Setters
  addMerchantToList(Merchant merchant) {
    _merchantList.add(merchant);
    notifyListeners();
  }

  setMerchantList(List<Merchant> merchantList) {
    _merchantList.addAll(merchantList);
    notifyListeners();
  }

  clearMerchantList() {
    _merchantList.clear();
    notifyListeners();
  }

  setActiveMerchant(Merchant merchant) {
    _activeMerchant = merchant;
    notifyListeners();
  }
}
