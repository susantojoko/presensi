import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AbsensiPage extends StatefulWidget {
  @override
  _AbsensiPageState createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  String jamMasuk = "";
  String jamKeluar = "";

  void absenMasuk() {
    setState(() {
      final currentTime = DateTime.now();
      jamMasuk = DateFormat('HH:mm').format(currentTime);
    });
  }

  void absenKeluar() {
    setState(() {
      final currentTime = DateTime.now();
      jamKeluar = DateFormat('HH:mm').format(currentTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Absensi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Jam Masuk: $jamMasuk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: absenMasuk,
              child: Text('Absen Masuk'),
            ),
            SizedBox(height: 20),
            Text(
              'Jam Keluar: $jamKeluar',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: absenKeluar,
              child: Text('Absen Keluar'),
            ),
          ],
        ),
      ),
    );
  }
}
