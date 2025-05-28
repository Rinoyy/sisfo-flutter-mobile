class ItemDetail {
  final int id;
  final String name;
  final int stock;

  ItemDetail({
    required this.id,
    required this.name,
    required this.stock,
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json) {
    return ItemDetail(
      id: json['id'],
      name: json['name'],
      stock: json['stock'],
    );
  }
}
