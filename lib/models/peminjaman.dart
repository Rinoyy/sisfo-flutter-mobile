import 'LoanDetail.dart';

class Peminjaman {
  final int id;
  final DateTime loanDate;
  final DateTime returnDate;
  final String reason;
  final String status;
  final int userId;
  final List<LoanDetail> loanDetails; // tambahkan ini

  Peminjaman({
    required this.id,
    required this.loanDate,
    required this.returnDate,
    required this.reason,
    required this.status,
    required this.userId,
    required this.loanDetails,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    var loanDetailsJson = json['loanDetails'] as List<dynamic>? ?? [];
    List<LoanDetail> loanDetailsList = loanDetailsJson.map((e) => LoanDetail.fromJson(e)).toList();

    return Peminjaman(
      id: json['id'],
      loanDate: DateTime.parse(json['loanDate']),
      returnDate: DateTime.parse(json['returnDate']),
      reason: json['reason'] ?? '',
      status: json['status'] ?? '',
      userId: json['userId'] ?? json['id_user'],
      loanDetails: loanDetailsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'loanDate': loanDate.toIso8601String(),
      'returnDate': returnDate.toIso8601String(),
      'reason': reason,
      'status': status,
      'userId': userId,
      'loanDetails': loanDetails.map((e) => e.toJson()).toList(),
    };
  }
}
