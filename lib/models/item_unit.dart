import 'item_detail.dart';
import 'item_category.dart';

class ItemUnit {
  final int id;
  final int itemsId;
  final String codeUnit;
  final int locationId;
  final int idCategory;
  final bool statusBorrowing;
  final String name;
  final ItemDetail item;
  final ItemCategory category;

  ItemUnit({
    required this.id,
    required this.itemsId,
    required this.codeUnit,
    required this.locationId,
    required this.idCategory,
    required this.statusBorrowing,
    required this.name,
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
      name: json['name'],
      statusBorrowing: json['status_borrowing'],
      // Hanya parse item dan category jika ada dalam JSON
      item: ItemDetail.fromJson(json['item']),
      category: ItemCategory.fromJson(json['category']),
    );
  }

  // Factory khusus untuk parsing dari keranjang response
  factory ItemUnit.fromKeranjangJson(Map<String, dynamic> json) {
    return ItemUnit(
      id: json['id'],
      itemsId: json['items_id'],
      codeUnit: json['code_unit'],
      locationId: json['location_id'],
      idCategory: json['id_category'],
      name: json['name'],
      statusBorrowing: json['status_borrowing'],
      item: ItemDetail.fromJson(json['item']),
      category: ItemCategory.fromJson(json['category']),
    );
  }
}
