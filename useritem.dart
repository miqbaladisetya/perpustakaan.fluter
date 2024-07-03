import 'package:flutter/material.dart';
import 'package:flutteruas/userdata.dart';

class UserItem extends StatelessWidget {
  final UserData userData;

  const UserItem({required this.userData, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.lightBlue,
            child: Text(
              userData.nama[0].toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userData.nama,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Umur: ${userData.umur}, Email: ${userData.email}"),
              ],
            ),
          )
        ],
      ),
    );
  }
}