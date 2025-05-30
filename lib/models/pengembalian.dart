import 'Loan.dart';
class Pengembalian {
  final int id;
  final int borrowingId;
  final int? idAchiver;
  final int itemCondition;
  final DateTime returnDate;
  final int idUser;
  final String status;
  final int? locationId;
  final Loan? loan;

  Pengembalian({
    required this.id,
    required this.borrowingId,
    this.idAchiver,
    required this.itemCondition,
    required this.returnDate,
    required this.idUser,
    required this.status,
    this.locationId,
    this.loan,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'],
      borrowingId: json['borrowing_id'],
      idAchiver: json['id_achiver'],
      itemCondition: json['item_condition'],
      returnDate: DateTime.parse(json['return_date']),
      idUser: json['id_user'],
      status: json['status'],
      locationId: json['location_id'],
      loan: json['loan'] != null ? Loan.fromJson(json['loan']) : null,
    );
  }
}
