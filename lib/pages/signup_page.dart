import 'package:flutter/material.dart';
import 'package:presensi/pages/login.dart';
import '../function/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool isObscured = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   shape: ContinuousRectangleBorder(
      //     borderRadius: BorderRadius.only(
      //       bottomRight: Radius.circular(50.0),
      //       bottomLeft: Radius.circular(50.0),
      //     ),
      //   ),
      //   toolbarHeight: 50,
      //   title: Padding(
      //     padding: const EdgeInsets.only(right: 30.0),
      //     child: Center(child: Text('Sign Up')),
      //   ),
      //   backgroundColor: Colors.blue,
      // ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 470,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                              child: Text(
                            'Sign UP',
                            style: TextStyle(fontSize: 30, color: Colors.white),
                          )),
                          SizedBox(height: 30),
                          _buildTextField(
                              "username", _usernameController, Icons.person),
                          SizedBox(
                            height: 10,
                          ),
                          _buildTextField(
                              "email", _emailController, Icons.email),
                          SizedBox(
                            height: 10,
                          ),
                          _buildTextField(
                            "password",
                            _passwordController,
                            Icons.lock,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                           Row(
                            children: [
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                ' I \'am have an account? ',
                                style: TextStyle(color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                      context); // Kembali ke halaman sebelumnya (biasanya ke halaman login)
                                },
                                child: Text('Login'),
                              ),
                            ],
                          ),
                          SizedBox(height: 20,),
                          Center(
                            child: Container(
                              height: 40,
                              width: 240,
                              child: ElevatedButton(
                                onPressed: () {
                                  _signUp();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors
                                      .blue.withOpacity(0.8), // Set warna latar belakang menjadi transparan
                                  onPrimary: Colors
                                      .blue, // Warna teks tombol saat ditekan
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Ubah sesuai kebutuhan Anda
                                    side: BorderSide(
                                      color: Colors
                                          .blue, // Warna garis tepi tombol
                                      width: 1.0, // Lebar garis tepi tombol
                                    ),
                                  ),
                                ),
                                child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                              Center(
                            child: Container(
                              height: 40,
                              width: 240,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Tindakan yang akan dijalankan saat tombol ditekan
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   Image.asset('assets/icon/google.png'),
                                    SizedBox(
                                        width: 8), // Spasi antara ikon dan teks
                                    Text(
                                      'Sign Up With Gmail',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(); // Menutup alert dialog setelah 3 detik
          });

          return AlertDialog(
            title: Text('Sign Up Successful'),
            content: Text('Congratulations! Your sign up was successful.'),
          );
        },
      );
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      print("Some error happened");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sign Up failed. Please try again.'),
        ),
      );
    }
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
            labelText: labelText,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    color: Colors.white,
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 2.0,
              ),
            ),
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            suffixIcon: isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isObscured =
                            !isObscured; // Toggle keadaan isObscured saat tombol mata ditekan
                      });
                    },
                    icon: Icon(
                      isObscured ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          obscureText: isPassword
              ? isObscured
              : false, // Menggunakan isObscured untuk mengontrol keadaan obscureText
        ),
      ),
    );
  }
}
