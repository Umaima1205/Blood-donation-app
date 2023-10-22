import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zindgiapp/Screens/Home_Screen.dart';
import 'package:zindgiapp/authentication/CreateAccount.dart';
import 'package:zindgiapp/authentication/Methods.dart';
import 'package:zindgiapp/utility/App_Colors.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  String _selectedUserType = 'User'; // Default user type
  bool isLoading = false;

  // List of user types
  final List<String> userTypes = ['User', 'Admin', 'Guest'];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Container(
                height: size.height / 20,
                width: size.height / 20,
                child: const CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: size.height / 10,
                  ),
                  SizedBox(
                    height: size.height / 350,
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: const Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 1.1,
                    child: Text(
                      "Sign In to Continue!",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "email", CupertinoIcons.person_alt_circle, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "password", CupertinoIcons.lock_circle, _password),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  // Dropdown field for user type selection
                  Container(
                    width: size.width / 1.1,
                    child: DropdownButton<String>(
                      value: _selectedUserType,
                      icon: Icon(CupertinoIcons.chevron_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: AppColors.RedColor),
                      underline: Container(
                        height: 2,
                        color: AppColors.RedColor,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedUserType = newValue!;
                        });
                      },
                      items: userTypes.map((String userType) {
                        return DropdownMenuItem<String>(
                          value: userType,
                          child: Text(userType),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 10,
                  ),
                  customButton(size),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => CreateAccount())),
                    child: const Text(
                      "Create Account",
                      style: TextStyle(
                        color: AppColors.RedColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return GestureDetector(
      onTap: () {
        if (_email.text.isNotEmpty && _password.text.isNotEmpty) {
          setState(() {
            isLoading = true;
          });

          logIn(_email.text, _password.text).then((user) {
            if (user != null) {
              print("Login Successful");
              setState(() {
                isLoading = false;
              });
              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeView()));
            } else {
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          print("Please fill out the form correctly");
        }
      },
      child: Container(
          height: size.height / 14,
          width: size.width / 1.1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.RedColor,
          ),
          alignment: Alignment.center,
          child: const Text(
            "Log In",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          )),
    );
  }

  Widget field(Size size, String hintText, IconData icon, TextEditingController cont) {
    return Container(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black, // Change the icon color here
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.RedColor, // Change the focused border color here
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.grey, // Change the border color here
            ),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
