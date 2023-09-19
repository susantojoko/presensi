import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:presensi/pages/home_page.dart';

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
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/rain.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3),
                BlendMode.darken,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(20),
                color: Colors.black.withOpacity(0.7),
                height: 400,
                width: 550,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/welcomeLogin.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    _buildTextField("Email", _emailController, Icons.person),
                    SizedBox(height: 10),
                    _buildTextField("Password", _passwordController, Icons.lock,
                        isPassword: true),
                    SizedBox(height: 5.0),
                    _buildForgotPasswordButton(context),
                    SizedBox(height: 10.0),
                    _buildLoginButton(context),
                    SizedBox(height: 16.0),
                    _buildSignUpButton(context),
                  ],
                ),
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
        width: 450,
        child: TextField(
          controller: controller,
          style: TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
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
      margin: EdgeInsets.only(left: 50),
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainHome()));
        },
        child: Text("Forgot Password"),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(30),
        ),
        child: ElevatedButton(
          onPressed: () async {
            _signIn(context);
          },
          child: Text('Login'),
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
        child: Text("Don't have an account? Sign Up"),
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
        Future.delayed(Duration(seconds: 2), () {
          Navigator.of(context).pop(); // Menutup dialog setelah 2 detik
          Navigator.push(context, MaterialPageRoute(builder: (context) => MainHome())); // Pindah halaman setelah dialog ditutup
        });
        return AlertDialog(
          title: Text('Login Successful'),
          content: Text('Congratulations! You have successfully logged in.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog jika tombol OK ditekan
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
          content: Text('Oops! Something went wrong. Please check your credentials.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog jika tombol OK ditekan
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
              Navigator.of(context).pop(); // Menutup dialog jika tombol OK ditekan
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}}
}
