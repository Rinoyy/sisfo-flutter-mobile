import 'item_unit.dart';

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
