class Pengembalian {
  final int id;
  final DateTime returnDate;
  final String status;
  final int idUser;

  Pengembalian({
    required this.id,
    required this.returnDate,
    required this.status,
    required this.idUser,
  });

  factory Pengembalian.fromJson(Map<String, dynamic> json) {
    return Pengembalian(
      id: json['id'] as int,
      returnDate: DateTime.parse(json['return_date']),
      status: json['status'] as String,
      idUser: json['id_user'] as int,
    );
  }
}
