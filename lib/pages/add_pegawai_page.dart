import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPegawai extends StatefulWidget {
  @override
  _AddPegawaiState createState() => _AddPegawaiState();
}

class _AddPegawaiState extends State<AddPegawai> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pegawai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _nipController,
              decoration: InputDecoration(labelText: 'NIP'),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                _signUp();
              },
              child: Text('Tambah Pegawai'),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String nip = _nipController.text;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: "password", // Isi dengan kata sandi default yang Anda inginkan
      );

      User? user = userCredential.user;

      if (user != null) {
        print("User is successfully created");

        Timestamp now = Timestamp.now(); // Dapatkan waktu saat ini

        await _firestore.collection('pegawai').doc(user.uid).set({
          'name': username,
          'email': email,
          'nip': nip,
          'create_at': now,
        });

        Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
      } else {
        print("Some error happened");
      }
    } catch (e) {
      print(e);
    }
  }
}
