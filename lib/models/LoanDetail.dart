import 'item_unit.dart';


class LoanDetail {
  final int id;
  final int idLoan;
  final int idItemUnit;
  final ItemUnit? itemUnit;

  LoanDetail({
    required this.id,
    required this.idLoan,
    required this.idItemUnit,
    this.itemUnit,
  });

  factory LoanDetail.fromJson(Map<String, dynamic> json) {
    return LoanDetail(
      id: json['id'],
      idLoan: json['id_loan'],
      idItemUnit: json['id_item_unit'],
      itemUnit: json['item_unit'] != null
          ? ItemUnit.fromJson(json['item_unit'])
          : null,
    );
  }

  factory LoanDetail.empty() {
    return LoanDetail(
      id: 0,
      idLoan: 0,
      idItemUnit: 0,
      itemUnit: null,
    );
  }
}
