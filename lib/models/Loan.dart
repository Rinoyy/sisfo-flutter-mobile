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
      id: json['id'],
      loanDate: DateTime.parse(json['loan_date']),
      returnDate: DateTime.parse(json['return_date']),
      reason: json['reason'],
      status: json['status'],
      idUser: json['id_user'],
      loanDetails: loanDetailsList,
    );
  }
}
