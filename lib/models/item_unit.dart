class ItemUnit {
  final int id;
  final int itemsId;
  final String codeUnit;
  final int locationId;
  final int idCategory;
  final bool statusBorrowing;

  ItemUnit({
    required this.id,
    required this.itemsId,
    required this.codeUnit,
    required this.locationId,
    required this.idCategory,
    required this.statusBorrowing,
  });

  factory ItemUnit.fromJson(Map<String, dynamic> json) {
    return ItemUnit(
      id: json['id'],
      itemsId: json['items_id'],
      codeUnit: json['code_unit'],
      locationId: json['location_id'],
      idCategory: json['id_category'],
      statusBorrowing: json['status_borrowing'],
    );
  }
}
