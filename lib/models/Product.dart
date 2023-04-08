class Product {
  String id;
  String merchant_id;
  String label;
  int stock_quantity;
  double base_price;
  List<String> categories;
  List<String> sub_categories;
  String created_time;
  String modified_time;
  String deleted_time;
  bool is_deleted;
  bool is_activated;

  Product({required this.id,
      required this.merchant_id,
      required this.label,
      required this.stock_quantity,
      required this.base_price,
      required this.categories,
      required this.sub_categories,
      required this.created_time,
      required this.modified_time,
      required this.deleted_time,
      required this.is_deleted,
      required this.is_activated});

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        merchant_id = json['merchant_id'],
        label = json['label'],
        stock_quantity = json['stock_quantity'],
        base_price = json['base_price'],
        categories = (json['categories'] as List).map((item) => item as String).toList() ?? [],
        sub_categories = (json['sub_categories'] as List).map((item) => item as String).toList() ?? [],
        created_time = json['created_time'],
        modified_time = json['modified_time'],
        deleted_time = json['deleted_time'] ?? "",
        is_deleted = json['is_deleted'],
        is_activated = json['is_activated'];
}
