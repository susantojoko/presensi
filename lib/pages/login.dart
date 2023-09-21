import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presensi/pages/forgot.dart';
import 'package:presensi/pages/home_page.dart';
import 'package:lottie/lottie.dart';

//nb
//sandi login email : ab@gmail.com password : ab12345

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background6.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.grey.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Center(
            child: Container(
              height: 380,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                  border: Border.all(
      color: Colors.black.withOpacity(0.3), // Warna border transparan
      width: 1.0, // Lebar border
    ),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.white.withOpacity(0.5), //Warna Banyangan
                //     blurRadius: 100, //Radius Kabur(Blur)
                //     spreadRadius: 2.0, // Radius Penyebaran
                //     // offset: Offset(-50, -50), //Posisi Bayangan
                //   )
                // ]
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 10, right: 50),
                      height: 50,
                      width: 100,
                      child: Lottie.asset(
              'assets/animasi/welcome2.json', // Sesuaikan dengan path animasi Lottie Anda
              fit: BoxFit.cover,
            ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  _buildTextField("Email", _emailController, Icons.email),
                  SizedBox(height: 10),
                  _buildTextField("Password", _passwordController, Icons.lock,
                      isPassword: true),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  _buildForgotPasswordButton(context),
                  _buildSignUpButton(context),
                  ],),
                  SizedBox(height: 16.0),
                  _buildLoginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String labelText, TextEditingController controller, IconData? prefixIcon,
      {bool isPassword = false}) {
    return Center(
      child: Container(
        width: 260,
        child: TextField(
          controller: controller,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: labelText, // Label teks untuk TextField
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: Colors.white,) 
                : null, // Ikona awalan jika ada
            border: UnderlineInputBorder(
              // Border saat TextField tidak fokus
              borderSide: BorderSide(
                color: Colors.blue, // Warna border bawah
                width: 2.0, // Lebar border bawah
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              // Border saat TextField dalam fokus
              borderSide: BorderSide(
                color: Colors.blue, // Warna border bawah saat dalam fokus
                width: 2.0, // Lebar border bawah saat dalam fokus
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              // Border saat TextField dalam keadaan aktif tetapi tidak dalam fokus
              borderSide: BorderSide(
                color: Colors
                    .grey, // Warna border bawah saat aktif tetapi tidak dalam fokus
                width:
                    2.0, // Lebar border bawah saat aktif tetapi tidak dalam fokus
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.white, // Warna teks label
            ),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured = !isObscured;
                      });
                    },
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          obscureText: isPassword ? isObscured : false,
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
        },
        child: Text("Forgot Password"),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: Container(
        height: 50,
        width: 280,
    //     decoration: BoxDecoration(
    //       color: Colors.black.withOpacity(0.1),
    //       borderRadius: BorderRadius.circular(30),
    //       border: Border.all(
    //       color: Colors.white.withOpacity(0.1), // Warna border putih dengan opasitas (transparan)
    //       width: 2.0, // Lebar border
    // ),
    //     ),
        child: ElevatedButton(
          onPressed: () async {
            _signIn(context);
          },
          style: ElevatedButton.styleFrom(
        primary: Colors.lightBlue.withOpacity(0.8), // Set warna latar belakang menjadi transparan
        onPrimary: Colors.blue, // Warna teks tombol saat ditekan
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Ubah sesuai kebutuhan Anda
          side: BorderSide(
            color: Colors.blue, // Warna garis tepi tombol
            width: 1.0, // Lebar garis tepi tombol
          ),
        ),
      ),
          child: Text('Login', style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
        },
        child: Text("Register"),
      ),
    );
  }

  void _signIn(BuildContext context) async {
    String email = _emailController.text;
    String password = _passwordController.text;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      if (user != null) {
        print("User is successfully signed in");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(); // Menutup dialog setelah 2 detik
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MainHome())); // Pindah halaman setelah dialog ditutup
            });
            return AlertDialog(
              title: Text('Login Successful'),
              content:
                  Text('Congratulations! You have successfully logged in.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Menutup dialog jika tombol OK ditekan
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print("Some error happened");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.of(context).pop(); // Menutup dialog setelah 2 detik
            });
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text(
                  'Oops! Something went wrong. Please check your credentials.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(); // Menutup dialog jika tombol OK ditekan
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 2), () {
            Navigator.of(context).pop(); // Menutup dialog setelah 2 detik
          });
          return AlertDialog(
            title: Text('Login Error'),
            content: Text('email/ password salah atau belum terdaftar'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Menutup dialog jika tombol OK ditekan
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
