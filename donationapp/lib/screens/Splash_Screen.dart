
import 'package:Zindgi/screens/login.dart';
import 'package:Zindgi/utility/App_Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
    
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      )
    );
        //navigate to home screen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginPage() ));
    
    
     
    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    var mq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.RedColor,
  // body
  body: Stack(
    children: [
      // app logo
      Positioned(
        top: mq.height * 0.10,
        right: mq.width * 0.25,
        width: mq.width * 0.5,
        child: Container(
          margin: const EdgeInsets.only(top: 150.0), // Add margin top here
          child: Image.asset('assests/images/blood.png'),
        ),
      ),

      // google login button
    Positioned(
  bottom: mq.height * 0.12,
  width: mq.width,
  child: Container(
    margin: const EdgeInsets.only(bottom: 200.0), // Add margin bottom here
    child: const Text(
      'Zindgi',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 40,
        color:AppColors.WhiteColor,
        letterSpacing: 0.5,
        fontWeight: FontWeight.w500
      ),
    ),
  ),
),

    ],
  ),
);

  }
}