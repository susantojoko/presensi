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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight,
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 400,
                    width: 500,
                    margin: EdgeInsets.only(top:50),
                    decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: Text('Sign UP', style: TextStyle(fontSize: 30, color: Colors.white),)),
                        SizedBox(height: 30),
                        _buildTextField("username", _usernameController, Icons.person),
                        SizedBox(
                          height: 10,
                        ),
                        _buildTextField("email", _emailController, Icons.person),
                        SizedBox(
                          height: 10,
                        ),
                        _buildTextField("password", _passwordController, Icons.person, isPassword:true,),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 30.0),
                        Center(
                          child: Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                _signUp();
                              },
                              child: Text('Sign Up'),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context); // Kembali ke halaman sebelumnya (biasanya ke halaman login)
                            },
                            child: Text('I already have an account? Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signUp() async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {
      print("User is successfully created");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 3), () {
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
 
  Widget _buildTextField(String labelText, TextEditingController controller, IconData? prefixIcon, {bool isPassword = false}) {
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
                      isObscured = !isObscured; // Toggle keadaan isObscured saat tombol mata ditekan
                    });
                  },
                  icon: Icon(
                    isObscured ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
        obscureText: isPassword ? isObscured : false, // Menggunakan isObscured untuk mengontrol keadaan obscureText
      ),
    ),
  );
}


}
