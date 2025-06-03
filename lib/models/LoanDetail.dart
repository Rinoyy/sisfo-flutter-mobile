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
      idLoan: json['loanId'],
      idItemUnit: json['itemUnitId'],
      itemUnit: json['itemUnit'] != null ? ItemUnit.fromJson(json['itemUnit']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanId': idLoan,
      'itemUnitId': idItemUnit,
      // 'itemUnit': itemUnit?.toJson(),
    };
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
