import 'package:flutter/material.dart';
import 'package:presensi/pages/add_pegawai_page.dart';
import 'package:presensi/pages/home_page.dart';
// import 'package:presensi/pages/add_pegawai_page.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){ 
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddPegawai()));
            // Navigator.pushNamed(context, '/AddPegawai');
            },
            child: Icon(Icons.person),
            ),
            ElevatedButton(onPressed: (){ 
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainHome()));
            // Navigator.pushNamed(context, '/AddPegawai');
            },
            child: Text('Halaman absensi'),
            ),
            Text('Halaman Home'),
          ],
        ),
      ),
    );
  }
}