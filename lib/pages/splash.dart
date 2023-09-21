import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;

  SplashScreen({required this.navigatorKey});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay untuk simulasi tampilan splash screen selama 2 detik
    Future.delayed(Duration(seconds: 5), () {
      // Pindah ke halaman beranda atau halaman utama aplikasi setelah splash screen
      widget.navigatorKey.currentState!.pushReplacementNamed('/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage('assets/images/splash1.png'),
           fit: BoxFit.cover,)
          ),
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                'assets/animasi/animasifish.json', // Ganti dengan path ke file animasi Lottie Anda
                fit: BoxFit.cover,
                width: 100,
                height: 200,
              ),
                  SizedBox(height: 10.0),
                  Text(
                    'APP PRESENSI',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}