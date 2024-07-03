class UserData {
  final String nama;
  final int umur;
  final String email;

  UserData({required this.nama, required this.umur, required this.email});

  @override
  String toString() {
    return 'UserData(nama: $nama, umur: $umur, email: $email)';
  }
}