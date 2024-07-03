import 'package:flutter/material.dart';
import 'package:flutteruas/userdata.dart';
import 'package:flutteruas/useritem.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserList extends StatefulWidget {
  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  List<UserData> _daftarUser = [];

  String _btnSimpanText = "Simpan";
  String _btnUbahText = "Ubah";
  Color _btnSimpanWarna = Colors.blueAccent;
  Color _btnUbahWarna = Colors.blueGrey;

  int _indexDipilih = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    labelText: "Nama",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: _umurController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Umur",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: ElevatedButton(
                  onPressed: () {
                    try {
                      if (_namaController.text.isEmpty ||
                          _umurController.text.isEmpty ||
                          _emailController.text.isEmpty)
                        throw new Exception("Isian tidak boleh kosong");

                      int umur = int.parse(_umurController.text);

                      if (_btnSimpanText == "Simpan") {
                        _daftarUser.add(UserData(_namaController.text, umur, _emailController.text));
                      } else {
                        UserData userData = _daftarUser[_indexDipilih];
                        userData.nama = _namaController.text;
                        userData.umur = umur;
                        userData.email = _emailController.text;

                        _btnSimpanText = "Simpan";
                        _btnSimpanWarna = Colors.blueAccent;
                      }
                      setState(() {});

                      _namaController.text = "";
                      _umurController.text = "";
                      _emailController.text = "";
                    } catch (e) {
                      Fluttertoast.showToast(
                        msg: '$e',
                      );
                    }
                  },
                  child: Text(_btnSimpanText),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 75),
                      backgroundColor: _btnSimpanWarna),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey(_daftarUser[index]),
                        child: InkWell(
                          child: UserItem(_daftarUser[index]),
                          onTap: () {
                            _namaController.text = _daftarUser[index].nama;
                            _umurController.text = _daftarUser[index].umur.toString();
                            _emailController.text = _daftarUser[index].email;

                            _btnSimpanText = _btnUbahText;
                            _btnSimpanWarna = _btnUbahWarna;

                            _indexDipilih = index;

                            setState(() {});
                          },
                        ),
                        background: Container(
                          padding: EdgeInsets.only(left: 10),
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        secondaryBackground: Container(
                          padding: EdgeInsets.only(left: 10),
                          color: Colors.white,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            _daftarUser.removeAt(index);

                            setState(() {});
                          }
                        },
                        confirmDismiss: (direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return await showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirm"),
                                  content:
                                      const Text("Apakah yakin akan menghapus"),
                                  actions: [
                                    ElevatedButton