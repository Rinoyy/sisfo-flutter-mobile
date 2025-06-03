import 'Loan.dart';
class Pengembalian {
  final int id;
  final int borrowingId;
  final int? idAchiver;
  final int itemCondition;
  final DateTime returnDate;
  final int userId;
  final String status;
  final int? locationId;
  final Loan? loan;

  Pengembalian({
    required this.id,
    required this.borrowingId,
    this.idAchiver,
    required this.itemCondition,
    required this.returnDate,
    required this.userId,
    required this.status,
    this.locationId,
    this.loan,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'],
      borrowingId: json['borrowingId'],
      idAchiver: json['idAchiver'],
      itemCondition: json['itemCondition'],
      returnDate: DateTime.parse(json['returnDate']),
      userId: json['userId'],
      status: json['status'],
      locationId: json['locationId'],
      loan: json['loan'] != null ? Loan.fromJson(json['loan']) : null,
    );
  }
}
