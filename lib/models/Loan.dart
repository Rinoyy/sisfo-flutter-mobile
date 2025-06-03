import 'LoanDetail.dart';

class Loan {
  final int id;
  final DateTime loanDate;
  final DateTime returnDate;
  final String? reason;
  final String status;
  final int idUser;
  final List<LoanDetail> loanDetails;

  Loan({
    required this.id,
    required this.loanDate,
    required this.returnDate,
    this.reason,
    required this.status,
    required this.idUser,
    required this.loanDetails,
  });

 factory Loan.fromJson(Map<String, dynamic> json) {
  var list = json['loanDetails'] as List<dynamic>? ?? [];
  List<LoanDetail> loanDetailsList =
      list.map((e) => LoanDetail.fromJson(e)).toList();

  return Loan(
    id: json['id'] ?? 0,
    loanDate: DateTime.tryParse(json['loanDate'] ?? '') ?? DateTime.now(),
    returnDate: DateTime.tryParse(json['returnDate'] ?? '') ?? DateTime.now(),
    reason: json['reason'], // ini sudah nullable
    status: json['status'] ?? 'UNKNOWN',
    idUser: json['userId'] ?? 0,
    loanDetails: loanDetailsList,
  );
}


}
