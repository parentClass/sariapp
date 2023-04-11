class MerchantCategory {
  String id;
  String label;
  String created_time;
  String modified_time;
  String deleted_time;
  bool is_deleted;
  bool is_activated;

  MerchantCategory(
      {required this.id,
      required this.label,
      required this.created_time,
      required this.modified_time,
      required this.deleted_time,
      required this.is_deleted,
      required this.is_activated});

  MerchantCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        label = json['label'],
        created_time = json['created_time'],
        modified_time = json['modified_time'],
        deleted_time = json['deleted_time'] ?? "",
        is_deleted = json['is_deleted'],
        is_activated = json['is_activated'];
}
