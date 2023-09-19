import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class ForgotPasswordPage extends StatefulWidget {
  // @override
  // _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _resetCodeController = TextEditingController();

//   String _resetEmail = '';
//   String _resetCode = '';
//   String _newPassword = '';

//   bool _resetCodeSent = false;
//   bool _passwordReset = false;

//   Future<void> _resetPassword(String email) async {
//     try {
//       await _auth.sendPasswordResetEmail(email: email);
//       setState(() {
//         _resetEmail = email;
//         _resetCodeSent = true;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> _confirmResetPassword(String newPassword, String oobCode) async {
//     try {
//       await _auth.confirmPasswordReset(
//         oobCode: oobCode,
//         newPassword: newPassword,
//       );
//       setState(() {
//         _passwordReset = true;
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
class name extends StatelessWidget {
  const name({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Center(
      //     child: _passwordReset
      //         ? Column(
      //             mainAxisAlignment: MainAxisAlignment.center,
      //             children: [
      //               Text('Password reset successfully!'),
      //               ElevatedButton(
      //                 onPressed: () {
      //                   // Navigasi ke halaman login atau halaman lain yang sesuai.
      //                 },
      //                 child: Text('Back to Login'),
      //               ),
      //             ],
      //           )
      //         : _resetCodeSent
      //             ? Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   TextFormField(
      //                     controller: _newPasswordController,
      //                     obscureText: true,
      //                     decoration: InputDecoration(labelText: 'New Password'),
      //                     onChanged: (value) {
      //                       setState(() {
      //                         _newPassword = value;
      //                       });
      //                     },
      //                   ),
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       _confirmResetPassword(_newPassword, _resetCode);
      //                     },
      //                     child: Text('Reset Password'),
      //                   ),
      //                 ],
      //               )
      //             : Column(
      //                 mainAxisAlignment: MainAxisAlignment.center,
      //                 children: [
      //                   TextFormField(
      //                     controller: _emailController,
      //                     keyboardType: TextInputType.emailAddress,
      //                     decoration: InputDecoration(labelText: 'Email'),
      //                     onChanged: (value) {
      //                       setState(() {
      //                         _resetEmail = value;
      //                       });
      //                     },
      //                   ),
      //                   ElevatedButton(
      //                     onPressed: () {
      //                       _resetPassword(_resetEmail);
      //                     },
      //                     child: Text('Send Reset Email'),
      //                   ),
      //                 ],
      //               ),
      //   ),
      // ),
    );
  }
}

