import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:Zindgi/utility/App_Colors.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool showProgress = false;
  bool visible = false;

  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpassController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobile = TextEditingController();
  bool _isObscure = true;
  bool _isObscure2 = true;
  File? file;
  var options = ['User', 'Manager'];
  var _currentItemSelected = "User";
  var rool = "User";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.RedColor,
     appBar: AppBar(
  toolbarHeight: 200, // Reduce the toolbar height
  flexibleSpace: Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.RedColor, // Background color of the AppBar
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assests/images/blood.png', // Replace with your image asset path
          width: 100, // Set the desired width
          height: 100, // Set the desired height
        ),
        Text(
          'Zindgi', // Your text
          style: TextStyle(
            color: AppColors.WhiteColor,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  ),
),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: AppColors.WhiteColor,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         const SizedBox(height: 40),
                        const Text(
                          'Create Account', // Add a heading after the AppBar
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Email',
                            contentPadding: const EdgeInsets.all(12), // Reduced size
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder( // Change focused border color
                              borderSide: const BorderSide(color: Colors.black), // Customize the color
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email cannot be empty";
                            }
                            if (!RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
                                .hasMatch(value)) {
                              return "Please enter a valid email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16), // Reduced size
                        TextFormField(
                          obscureText: _isObscure,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Password',
                            contentPadding: const EdgeInsets.all(12), // Reduced size
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder( // Change focused border color
                              borderSide: const BorderSide(color: Colors.black), // Customize the color
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Password cannot be empty";
                            }
                            if (value.length < 6) {
                              return "Password must be at least 6 characters";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16), // Reduced size
                        TextFormField(
                          obscureText: _isObscure2,
                          controller: confirmpassController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isObscure2 ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Confirm Password',
                            contentPadding: const EdgeInsets.all(12), // Reduced size
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder( // Change focused border color
                              borderSide: const BorderSide(color: Colors.black), // Customize the color
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "User Type: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: AppColors.RedColor,
                              ),
                            ),
                            DropdownButton<String>(
                              dropdownColor: AppColors.WhiteColor,
                              items: options.map((String dropDownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropDownStringItem,
                                  child: Text(
                                    dropDownStringItem,
                                    style: const TextStyle(
                                      color:AppColors.RedColor,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValueSelected) {
                                setState(() {
                                  _currentItemSelected = newValueSelected!;
                                  rool = newValueSelected;
                                });
                              },
                              value: _currentItemSelected,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16), // Reduced size
                       ElevatedButton(
  style: ElevatedButton.styleFrom(
    primary: AppColors.RedColor,
    onPrimary: AppColors.WhiteColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    minimumSize: const Size(800, 40), // Increase the width to 300
  ),
  onPressed: () {
    setState(() {
      showProgress = true;
    });
    signUp(emailController.text, passwordController.text, rool);
  },
  child: const Text(
    "Register",
    style: TextStyle(
      fontSize: 20,
    ),
  ),
),

                        const SizedBox(height: 12), // Reduced size
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Already a member? Login",
                            style: TextStyle(
                              color: AppColors.RedColor,
                              fontSize: 16,
                            ),
                          ),
                        ),
                     
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUp(String email, String password, String rool) async {
    if (_formkey.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(email: email, password: password);
        postDetailsToFirestore(email, rool);
      } catch (e) {
        // Handle registration errors here
        print(e.toString());
      }
    }
  }

  postDetailsToFirestore(String email, String rool) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(user!.uid).set({'email': emailController.text, 'rool': rool});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
