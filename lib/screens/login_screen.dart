import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';
import 'package:mizan/database/shardprefrance.dart';
import 'package:mizan/screens/main_screen.dart';
import 'package:mizan/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>(); // مفتاح النموذج للتحقق من الإدخالات
  bool isAccountVisible = false;
  bool isPasswordVisible = false;
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    SharedPref.initial();  // تهيئة shared preferences عند تحميل الصفحة
    _checkLoginStatus();  // التحقق من حالة تسجيل الدخول عند بدء التطبيق
  }

  //  علشان التحقق إذا كان هناك بيانات تسجيل دخول مخزنة 
  void _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool("isLoggedIn") ?? false;
    if (isLoggedIn) {
     // إذا كان المستخدم قد سجل الدخول مسبقًا، يتم الانتقال إلى الشاشة الرئيسية مباشرة
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    }
  }
  
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'ميزان',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: kfontStyle4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/login.gif",
                height: 300,
                fit: BoxFit.fitHeight,
              ),
              buildTextFormField("اسم المستخدم"),
              buildTextFormField("البريد الإلكتروني"),
              buildTextFormField(
                "رقم الحساب",
                isPassword: true,
                isVisible: isAccountVisible,
                toggleVisibility: () {
                  setState(() {
                    isAccountVisible = !isAccountVisible;
                  });
                },
              ),
              buildTextFormField(
                "كلمة السر",
                isPassword: true,
                isVisible: isPasswordVisible,
                toggleVisibility: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    ":اختر الدولة",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedCountry,
                    hint: const Text("اختر"),
                    items: countries.map((country) {
                      return DropdownMenuItem<String>(
                        value: country,
                        child: Text(country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCountry = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: kPrimaryColor3),
                child: const Text("تسجيل الدخول", style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedCountry == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("يرجى اختيار دولة",
                              style: TextStyle(color: Colors.black)),
                          backgroundColor: Color.fromARGB(136, 244, 67, 54),
                        ),
                      );
                      return;
                    }

                    
                    await SharedPref.storeData(
                      key: "isLoggedIn",
                      value: true, 
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


}
