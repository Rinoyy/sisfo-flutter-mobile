import 'item_detail.dart';
import 'item_category.dart';

class ItemUnit {
  final int id;
  final int itemId; // sesuaikan ini
  final String codeUnit;
  final int locationId;
  final int categoryId; // sesuaikan ini
  final bool statusBorrowing;
  final String name;
  final ItemDetail item;
  final ItemCategory category;
  final String? image;

  ItemUnit({
    required this.id,
    required this.itemId,
    required this.codeUnit,
    required this.locationId,
    required this.categoryId,
    required this.statusBorrowing,
    required this.name,
    required this.item,
    required this.category,
    this.image,
  });
  factory ItemUnit.fromJson(Map<String, dynamic> json) {
  

    return ItemUnit(
      id: json['id'],
      itemId: json['itemId'],
      codeUnit: json['codeUnit'],
      locationId: json['locationId'],
      categoryId: json['categoryId'],
      name: json['name'],
      statusBorrowing: json['statusBorrowing'],
      item: json['item'] != null
          ? ItemDetail.fromJson(json['item'])
          : ItemDetail(id: 0, name: '', stock: 0),
      category: json['category'] != null
          ? ItemCategory.fromJson(json['category'])
          : ItemCategory(id: 0, name: ''),
      image: json['image'],
    );
  }
  
  // Factory khusus untuk parsing dari keranjang response
  factory ItemUnit.fromKeranjangJson(Map<String, dynamic> json) {
    return ItemUnit(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      itemId: json['itemId'] ?? json['item_id'] ?? 0,
      image: json['image'],
      codeUnit: json['codeUnit'] ?? json['code_unit'] ?? '',
      locationId: json['locationId'] ?? json['location_id'] ?? 0,
      categoryId: json['categoryId'] ?? json['category_id'] ?? 0,
      statusBorrowing:
          json['statusBorrowing'] ?? json['status_borrowing'] ?? false,
      item: json['item'] != null
          ? ItemDetail.fromJson(json['item']) // pakai ItemDetail
          : ItemDetail(id: 0, name: '', stock: 0),
      category: json['category'] != null
          ? ItemCategory.fromJson(json['category']) // pakai ItemCategory
          : ItemCategory(id: 0, name: ''),
    );
  }
}
