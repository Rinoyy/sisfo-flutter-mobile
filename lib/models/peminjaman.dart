class Peminjaman {
  final int id;
  final DateTime loanDate;
  final DateTime returnDate;
  final String reason;
  final String status;
  final int idUser;
  // Tambahkan properti lain yang kamu butuhkan, misal loanDetails dll.

  Peminjaman({
    required this.id,
    required this.loanDate,
    required this.returnDate,
    required this.reason,
    required this.status,
    required this.idUser,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'] as int,
      loanDate: DateTime.parse(json['loan_date']),
      returnDate: DateTime.parse(json['return_date']),
      reason: json['reason'] as String,
      status: json['status'] as String,
      idUser: json['id_user'] as int,
    );
  }
}
