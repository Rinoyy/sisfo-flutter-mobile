class Pengembalian {
  final int id;
  final DateTime loanDate;
  final DateTime returnDate;
  final String reason;
  final String status;
  final int idUser;

  Pengembalian({
    required this.id,
    required this.loanDate,
    required this.returnDate,
    required this.reason,
    required this.status,
    required this.idUser,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'] as int,
      loanDate: DateTime.parse(json['loan_date'] as String),
      returnDate: DateTime.parse(json['return_date'] as String),
      reason: json['reason'] as String,
      status: json['status'] as String,
      idUser: json['id_user'] as int,
    );
  }
}
