class ProductCategory {
  String id;
  String label;
  String merchant_id;
  List<String> sub_categories;
  String created_time;
  String modified_time;
  String deleted_time;
  bool is_deleted;
  bool is_activated;

  ProductCategory(
      {required this.id,
      required this.label,
      required this.merchant_id,
      required this.sub_categories,
      required this.created_time,
      required this.modified_time,
      required this.deleted_time,
      required this.is_deleted,
      required this.is_activated});

  ProductCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        merchant_id = json['merchant_id'],
        sub_categories = (json['sub_categories'] as List)
            .map((item) => item as String)
            .toList(),
        created_time = json['created_time'],
        modified_time = json['modified_time'],
        deleted_time = json['deleted_time'] ?? "",
        is_deleted = json['is_deleted'],
        is_activated = json['is_activated'];
}
