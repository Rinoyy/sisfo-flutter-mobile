import '../models/item_unit.dart';

class KeranjangResponse {
  final bool success;
  final String message;
  final List<KeranjangItem> data;

  KeranjangResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory KeranjangResponse.fromJson(Map<String, dynamic> json) {
    return KeranjangResponse(
      success: json['success'],
      message: json['message'],
      data: List<KeranjangItem>.from(
        json['data'].map((item) => KeranjangItem.fromJson(item)),
      ),
    );
  }
}

class KeranjangItem {
  final int id;
  final int idUser;
  final int idItemsUnit;
  final ItemUnit itemUnit; // Tambahkan field ini

  KeranjangItem({
    required this.id,
    required this.idUser,
    required this.idItemsUnit,
    required this.itemUnit,
  });

  factory KeranjangItem.fromJson(Map<String, dynamic> json) {
    return KeranjangItem(
      id: json['id'],
      idUser: json['id_user'],
      idItemsUnit: json['id_items_unit'],
      itemUnit: ItemUnit.fromKeranjangJson(json['itemUnit']), // Gunakan factory khusus
    );
  }
}