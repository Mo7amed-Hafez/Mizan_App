import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';
import 'package:mizan/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double imageOpacity = 0.0;
  double textOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // أولاً: تظهر الصورة بتدريج
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        imageOpacity = 1.0;
      });
    });

    // بعد شوية، تظهر الكلمة بتدريج
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        textOpacity = 1.0;
      });
    });

    //  الانتقال للشاشة التالية بعد 4 ثواني
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>  LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              // علشان الصورة تظهر بتدريج
              opacity: imageOpacity,
              duration: const Duration(seconds: 1),
              child: Image.asset("assets/images/mizan.png"),
            ),
            const SizedBox(height: 5),
            AnimatedOpacity(
              // علشان الكلمة تظهر بتدريج
              opacity: textOpacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                "ميزان",
                style: TextStyle(
                  fontFamily: kfontStyle5,
                  color: Colors.white, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
