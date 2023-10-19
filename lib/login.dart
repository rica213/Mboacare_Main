import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_up_page.dart';
import 'register.dart';
import 'colors.dart';
import 'dart:developer' as devtools show log;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required String title}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  bool _isPasswordVisible = false;

  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _checkUserLoggedIn();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        _showMessage("Please enter email and password.");
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        if (!user.emailVerified) {
          await user.sendEmailVerification();
          _showMessage(
              "A verification email has been sent to your email address. Please verify your email.");
        } else {
          _saveUserEmail(user.email!);
          _showMessage("Sign in successful: ${user.email}");
          if (mounted) {
            // Navigate to register.dart
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RegisterPage()),
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMessage("User account not found. Please sign in with Google.");
      } else {
        _showMessage("Sign in failed: ${e.toString()}");
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleUser = _googleSignIn.currentUser;

      googleUser ??= await _googleSignIn.signIn();

      if (googleUser != null) {
        _navigatetoHospitalRegistrationForm();
      }
    } catch (e) {
      _showMessage("Google sign-in failed: ${e.toString()}");
    }
  }

  // Future<void> _sendVerificationEmail(User user) async {
  //   try {
  //     await user.sendEmailVerification();
  //     _showMessage(
  //         "A verification email has been sent to your email address. Please verify your email.");
  //   } catch (e) {
  //     _showMessage("Email verification failed: ${e.toString()}");
  //   }
  // }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _navigatetoHospitalRegistrationForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const RegisterPage()));
  }

  _saveUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_email', email);
  }

  Future<String?> _getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_email');
  }

  _checkUserLoggedIn() async {
    String? userEmail = await _getUserEmail();
    if (userEmail != null && userEmail.isNotEmpty) {
      devtools.log(userEmail);
      // _navigateToRegisterPage();
    }
  }

  Future<void> _sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showMessage(
          "A password reset email has been sent to your email address. Please follow the instructions to reset your password.");
    } catch (e) {
      _showMessage("Password reset email failed: ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assests/images/logo.png',
                width: 120,
              ),
              const SizedBox(height: 12),
               Text(
                AppStrings.welcome,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 14),
               Text(
                AppStrings.details,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                  color: AppColors.greenColor,
                ),
              ),
              const SizedBox(height: 20),
               Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Text(
                      AppStrings.email,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: AppColors.greenColor),
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: AppColors.greenColor,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding:  const EdgeInsets.symmetric(horizontal: 1.0),
                  child: TextField(
                    controller: _emailController,
                    decoration:  InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10.0,
                      ),
                      hintText: AppStrings.enter,
                      labelStyle: const TextStyle(color: AppColors.hintTextColor,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
               Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      AppStrings.password,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: AppColors.greenColor),
                    ),
                  )),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.0,
                    color: AppColors.password,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1.0),
                  child: TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 10.0,
                      ),
                      hintText: AppStrings.enterPassword,
                      labelStyle:
                          const TextStyle(color: AppColors.hintTextColor,
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,),
                      border: InputBorder.none,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        child: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        activeColor: Colors.green,
                      ),
                      Text(
                        AppStrings.remember,
                        style: const TextStyle(
                            color: AppColors.signInButtonColor,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      if (_emailController.text.isNotEmpty) {
                        _sendPasswordResetEmail(_emailController.text.trim());
                      } else {
                        _showMessage(
                            "Please enter your email to reset the password.");
                      }
                    },
                    child:  Text(
                      AppStrings.forgot,
                      style: const TextStyle(
                          color: AppColors.signInButtonColor,
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
              // Login with Email Button
              ElevatedButton(
                onPressed: _signInWithEmailAndPassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(340, 45),
                ),
                child: Text(
                  AppStrings.sign,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    color: AppColors.navbar,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Login with Google Button
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(340, 45),
                ),
                icon: Image.asset(
                  AppImages.googleIcon,
                  height: 32,
                  width: 32,
                ),
                label:Text(
                  AppStrings.signIn,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    color: AppColors.greenColor,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const SignUpPage()));
                },
                  child:RichText(
                    text:  TextSpan(
                      children: [
                        TextSpan(
                            text: AppStrings.account,
                          style: const TextStyle(
                            color: Colors.green,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400
                          )
                        ),
                        TextSpan(
                          text: AppStrings.signUp,
                          style: const TextStyle(
                            color: Colors.green,
                              fontSize: 14,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600// Set the color for "Sign up"
                          ),
                        ),
                      ],
                    ),
                  )

              ),
            ],
          ),
        ),
      ),
    );
  }
}
