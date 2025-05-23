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

class ItemCategory {
  final int id;
  final String name;

  ItemCategory({
    required this.id,
    required this.name,
  });

  factory ItemCategory.fromJson(Map<String, dynamic> json) {
    return ItemCategory(
      id: json['id'],
      name: json['name'],
    );
  }
}

class ItemUnit {
  final int id;
  final int itemsId;
  final String codeUnit;
  final int locationId;
  final int idCategory;
  final bool statusBorrowing;
  final ItemDetail item;
  final ItemCategory category;

  ItemUnit({
    required this.id,
    required this.itemsId,
    required this.codeUnit,
    required this.locationId,
    required this.idCategory,
    required this.statusBorrowing,
    required this.item,
    required this.category,
  });

  factory ItemUnit.fromJson(Map<String, dynamic> json) {
    return ItemUnit(
      id: json['id'],
      itemsId: json['items_id'],
      codeUnit: json['code_unit'],
      locationId: json['location_id'],
      idCategory: json['id_category'],
      statusBorrowing: json['status_borrowing'],
      item: ItemDetail.fromJson(json['item']),
      category: ItemCategory.fromJson(json['category']),
    );
  }
}

// Ini adalah pembungkus respons API
class ItemUnitResult {
  final bool success;
  final String message;
  final List<ItemUnit> data;

  ItemUnitResult({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ItemUnitResult.fromJson(Map<String, dynamic> json) {
    return ItemUnitResult(
      success: json['success'],
      message: json['message'],
      data: (json['data'] as List)
          .map((itemJson) => ItemUnit.fromJson(itemJson))
          .toList(),
    );
  }
}
