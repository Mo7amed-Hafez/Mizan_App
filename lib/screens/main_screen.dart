import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';
import 'package:mizan/screens/dolar_1screen.dart';
import 'package:mizan/screens/installments2.dart';
import 'package:mizan/screens/manging_3screen.dart';
import 'package:mizan/screens/personal4.dart';
import 'package:mizan/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String username = "اسم المستخدم";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("name") ?? "اسم المستخدم";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: const Text(
            'ميزان',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: kfontStyle4,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(9.8),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            "assets/images/logo (2).png",
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const SizedBox(height: 25),
                        Container(
                          padding: const EdgeInsets.all(5),
                          alignment: Alignment.centerRight,
                          height: MediaQuery.of(context).size.height * 0.15,
                          width: MediaQuery.of(context).size.width * 0.75,
                          decoration: BoxDecoration(
                            color: kPrimaryColor2,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                          ),
                          child: Text(
                            "   اهلا بك في الميزان يا $username   ",

                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: kfontStyle1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Dolarscreen(),
                      ),
                    );
                  },
                  child: buildContainer(
                    " حساب تحويل العملات الي الدولار",
                    "assets/images/dolar.png",
                    context,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InstallmentsScreen(),
                      ),
                    );
                  },
                  child: buildContainer(
                    "عرض الاقساط و مواعيدها",
                    "assets/images/aqsat.jpg",
                    context,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Mangingscreen(),
                      ),
                    );
                  },
                  child: buildContainer(
                    "تنظيم المصروفات بالنسبة لدخلك الشهري",
                    "assets/images/masrouf.png",
                    context,
                  ),
                ),
                const SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalScreen(),
                      ),
                    );
                  },
                  child: buildContainer(
                    "البيانات الشخصية",
                    "assets/images/data.jpg",
                    context,
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
