import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:presensi/pages/home_page.dart';
import 'firebase_options.dart';
import 'pages/login.dart';
import 'pages/signup_page.dart';
import 'pages/onboarding.dart';
import 'pages/splash.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,);

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  runApp(MyApp(navigatorKey: navigatorKey));
}

class MyApp extends StatefulWidget {

  final GlobalKey<NavigatorState> navigatorKey;

  MyApp({required this.navigatorKey});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      title: "Ecommerce",
      initialRoute: '/',
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/main': (context) => MainHome(),
        '/onboarding' : (context) => OnboardingPage(),

        
      },
      home: SplashScreen(navigatorKey: widget.navigatorKey),
    );
  }
}



