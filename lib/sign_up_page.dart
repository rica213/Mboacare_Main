import 'dart:convert';
import 'dart:developer' as devtools show log;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mboacare/login.dart';
import 'package:mboacare/register.dart';
import 'package:mboacare/utils/constants.dart';
import 'package:mboacare/utils/validations.dart';
import 'package:mboacare/view_model/signup_view_model.dart';
import 'package:mboacare/widgets/custom_btn.dart';
import 'package:mboacare/widgets/input_fields.dart';
import 'package:mboacare/widgets/password_validation_view.dart';
import 'package:provider/provider.dart';
import 'colors.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _nameController =
      TextEditingController(); // New controller for Name
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String _registrationStatus = '';
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final String documentId =
      'aeac9fSTIeI6UD0OywSj'; // ID of the document to fetch
  final String collectionName = 'sendgrid'; // Name of the collection
  final String fieldName = 'apiKey'; // Name of the field to retrieve
  String apiKeySG = '';

  @override
  void initState() {
    super.initState();
    fetchApiKey();
  }

  Future<void> fetchApiKey() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(documentId)
          .get();
      if (documentSnapshot.exists) {
        apiKeySG = documentSnapshot.get(fieldName);
        devtools.log(apiKeySG);
      } else {
        devtools.log('Document not found');
      }
    } catch (error) {
      devtools.log('Error fetching data: $error');
    }
  }

  Future<void> sendWelcomeEmail(
      String recipientEmail, String recipientName) async {
    String apiKey = apiKeySG;
    final Uri uri = Uri.https(
      'api.sendgrid.com',
      '/v3/mail/send',
    );

    final Map<String, dynamic> data = {
      'personalizations': [
        {
          'to': [
            {
              'email': recipientEmail,
              'name': recipientName
            }, // Included recipient's name
          ],
          'subject': 'Welcome to Mboacare!',
        },
      ],
      'from': {'email': 'mboacare@gmail.com'},
      'content': [
        {
          'type': 'text/plain',
          'value': '''
Dear $recipientName,

Welcome to Mboacare! We're thrilled to have you as part of our community. Your commitment to better healthcare accessibility is appreciated.

Thank you for signing up. We look forward to providing you with a seamless experience as you explore medical facilities and connect with healthcare experts.

If you have any questions or need assistance, feel free to reach out to us anytime. Once again, welcome aboard!

Best regards,
The Mboacare Team
        '''
        },
      ],
    };

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 202) {
      devtools.log('Email sent successfully');
    } else {
      devtools.log('Failed to send email. Status code: ${response.statusCode}');
    }
  }

  void _signUpWithEmailAndPassword() async {
    try {
      final String password = _passwordController.text;
      final String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        setState(() {
          _registrationStatus = 'Passwords do not match';
        });
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      final User? user = userCredential.user;

      if (user != null) {
        await user.updateDisplayName(_nameController.text.trim());

        sendWelcomeEmail(_emailController.text, _nameController.text.trim());

        setState(() {
          _registrationStatus = 'Registration successful';
        });
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        }
      }
    } catch (e) {
      setState(() {
        _registrationStatus = 'Registration failed: ${e.toString()}';
      });
    }
  }

  Future<void> _signUpWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      var result = await googleSignIn.signIn();
      if (result == null) {
        return;
      }

      final userData = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: userData.accessToken,
        idToken: userData.idToken,
      );
      var finalResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = finalResult.user;

      if (user != null) {
        setState(() {
          _registrationStatus = 'Google sign-in successful';
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isSignedIn', true);
        prefs.setString('email', user.email ?? "");
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
          );
        }
      }
    } catch (error) {
      devtools.log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: AppFontSizes.fontSize30,
            left: AppFontSizes.fontSize30,
            right: AppFontSizes.fontSize30,
            bottom: AppFontSizes.fontSize30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appLogo,
                  width: AppFontSizes.fontSize125,
                ),
                SizedBox(
                  height: AppFontSizes.fontSize10,
                ),
                Text(
                  ' Create an account',
                  style: GoogleFonts.inter(
                    fontSize: AppFontSizes.fontSize24,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(
                  height: AppFontSizes.fontSize30,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize4),
                      child: Text(
                        'Name *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                    hintText: "Enter your name",
                    onChanged: (value) {
                      setState(() {
                        provider.setName(value);
                        provider.validRegister();
                      });
                    },
                    controller: provider.nameController),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: AppFontSizes.fontSize1),
                      child: Text(
                        'Email *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                    hintText: "Enter your email",
                    onChanged: (value) {
                       setState(() {
                        provider.setEmail(value);
                        provider.validRegister();
                       });
                    },
                    controller: provider.emailController),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: AppFontSizes.fontSize4,
                          bottom: AppFontSizes.fontSize1),
                      child: Text(
                        'Password *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                  hintText: "Enter your password",
                  controller: provider.passwordController,
                  autofillHints: const [AutofillHints.newPassword],
                  onChanged: (value) {
                    setState(() {
                      provider.setPassword(value);
                      provider.validRegister();
                    });
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize20),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: AppFontSizes.fontSize4,
                          bottom: AppFontSizes.fontSize1),
                      child: Text(
                        'Confirm Password *',
                        style: GoogleFonts.inter(
                          fontSize: AppFontSizes.fontSize14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    )),
                SizedBox(height: AppFontSizes.fontSize10),
                EditTextForm(
                  hintText: "Confirm your password",
                  controller: provider.confirmPasswordController,
                  autofillHints: const [AutofillHints.newPassword],
                  onChanged: (value) {
                    setState(() {
                      provider.setConfirmPassword(value);
                      provider.validRegister();
                    });
                  },
                ),
                SizedBox(height: AppFontSizes.fontSize18),
                PasswordValidationView(
                  condition: passwordHasMinLength,
                  text: 'Must be at least 8 characters',
                  controller: provider.passwordController,
                ),
                SizedBox(height: AppFontSizes.fontSize8),
                PasswordValidationView(
                  condition: passwordHasSpecialCharacter,
                  text: 'Must contain one special character',
                  controller: provider.passwordController,
                ),
                SizedBox(height: AppFontSizes.fontSize18),
                AppButton(
                  onPressed: provider.signUpWithEmailAndPassword,
                  title: "Register",
                  enabled: provider.isValidRegister,
                  //model.isValidRegister
                ),
                SizedBox(height: AppFontSizes.fontSize1),
                Text(
                  provider.registrationStatus,
                  style: GoogleFonts.inter(
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: AppFontSizes.fontSize1),
                AppBorderButton(
                  onPressed: () {
                    provider.signUpWithGoogle(
                      onSuccessNavigate: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      }
                    );
                  },
                  title: "Register with Google",
                  showImage: true,
                  image: AppImages.googleIcon,
                  borderColor: AppColors.borderColor,
                  textColor: AppColors.greenColor,
                  //model.isValidRegister
                ),
                SizedBox(height: AppFontSizes.fontSize16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                const LoginScreen(title: "Mboacare")));
                  },
                  child: Text(
                    "Already have an account? Log in",
                    style: GoogleFonts.inter(
                      color: AppColors.greenColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
