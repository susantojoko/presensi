import 'package:flutter/material.dart';
import 'package:presensi/pages/absensi.dart';

class MainHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absensi App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat Datang di Aplikasi Absensi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AbsensiPage()));
                // Tambahkan logika untuk pergi ke halaman absensi di sini
              },
              child: Text('Absensi Sekarang'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk pergi ke halaman riwayat absensi di sini
              },
              child: Text('Riwayat Absensi'),
            ),
          ],
        ),
      ),
    );
  }
}
