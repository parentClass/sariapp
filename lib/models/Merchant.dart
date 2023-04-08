import 'package:sariapp/models/AccountType.dart';
import 'package:sariapp/models/MembershipType.dart';
import 'package:sariapp/models/MerchantType.dart';

class Merchant {
  String id;
  String account_id;
  String owner_name;
  String owner_address;
  String owner_contact;
  String merchant_name;
  String merchant_contact;
  String merchant_address;
  String merchant_region;
  MerchantType merchant_type;
  double total_income;
  double average_income;
  int customer_count;
  int average_traffic;
  int total_visits;
  int sku_id;
  MembershipType membership_type;
  String membership_start;
  String membership_end;
  String last_sync;
  String created_time;
  String modified_time;
  String deleted_time;
  bool is_deleted;
  bool is_activated;


  Merchant(
      {required this.id,
        required this.account_id,
        required this.owner_name,
        required this.owner_address,
        required this.owner_contact,
        required this.merchant_name,
        required this.merchant_contact,
        required this.merchant_address,
        required this.merchant_region,
        required this.merchant_type,
        required this.total_income,
        required this.average_income,
        required this.customer_count,
        required this.average_traffic,
        required this.total_visits,
        required this.sku_id,
        required this.membership_type,
        required this.membership_start,
        required this.membership_end,
        required this.last_sync,
        required this.created_time,
        required this.modified_time,
        required this.deleted_time,
        required this.is_deleted,
        required this.is_activated});

  Merchant.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        account_id = json["account_id"],
        owner_name = json["owner_name"],
        owner_address = json["owner_address"],
        owner_contact = json["owner_contact"],
        merchant_name = json["merchant_name"],
        merchant_contact = json["merchant_contact"],
        merchant_address = json["merchant_address"],
        merchant_region = json["merchant_region"],
        merchant_type = MerchantType.values.byName("${json['merchant_type']}".toUpperCase()),
        total_income = json["total_income"],
        average_income = json["average_income"],
        customer_count = json["customer_count"],
        average_traffic = json["average_traffic"],
        total_visits = json["total_visits"],
        sku_id = json["sku_id"] ?? 0,
        membership_type = MembershipType.values.byName("${json['membership_type']}".toUpperCase()),
        membership_start = json["membership_start"] ?? "",
        membership_end = json["membership_end"] ?? "",
        last_sync = json["last_sync"],
        created_time = json["created_time"],
        modified_time = json["modified_time"],
        deleted_time = json["deleted_time"] ?? "",
        is_deleted = json["is_deleted"],
        is_activated = json["is_activated"];
}
