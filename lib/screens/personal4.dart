import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';
import 'package:mizan/widgets/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';  

class PersonalScreen extends StatefulWidget {
  const PersonalScreen({super.key});

  @override
  State<PersonalScreen> createState() => _PersonalScreenState();
}

class _PersonalScreenState extends State<PersonalScreen> {
  String? selectedCountry;
  bool isBankVisible = false;
  bool isSalaryVisible = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bankController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();

  String displayName = "اسم المستخدم";
  String displayEmail = "البريد الإلكتروني";
  String displayCountry = "البلد";

  @override
  void initState() {
    super.initState();
    _loadUserData();  // تحميل البيانات من SharedPreferences عند بدء الصفحة
  }

  // تحميل البيانات من SharedPreferences
  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString("name") ?? "اسم المستخدم";
      displayEmail = prefs.getString("email") ?? "البريد الإلكتروني";
      displayCountry = prefs.getString("country") ?? "البلد";
      _bankController.text = prefs.getString("bankAccount") ?? "";
      _salaryController.text = prefs.getString("salary") ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    var percent = 0.5;
    return Scaffold(
      backgroundColor: kPrimaryColor,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  height: MediaQuery.of(context).size.height * .65,
                  width: MediaQuery.of(context).size.width * 0.92,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xFFBEC6A0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(height: 50),
                      Text(
                        displayName,
                        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        displayEmail,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFF708871),
                        ),
                        child: Text(
                          selectedCountry ?? displayCountry,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircularPercentIndicator(
                            radius: 40,
                            lineWidth: 5,
                            percent: percent,
                            footer: Text("الحساب البنكي", style: TextStyle(fontSize: 10, fontFamily: kfontStyle3)),
                            center: SizedBox(
                              width: 39,
                              child: Text(
                                _bankController.text,
                                style: const TextStyle( fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ),
                            progressColor: kPrimaryColor3,
                            backgroundColor: const Color(0x6A4489FF),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                          CircularPercentIndicator(
                            radius: 40,
                            lineWidth: 5,
                            percent: percent,
                            footer: Text("الحساب الشهري", style: TextStyle(fontSize: 10, fontFamily: kfontStyle3)),
                            center: SizedBox(
                              width: 39,
                              child: Text(
                                _salaryController.text,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 2,
                              ),
                            ),
                            progressColor: kPrimaryColor3,
                            backgroundColor: const Color(0x6A4489FF),
                            circularStrokeCap: CircularStrokeCap.round,
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _nameController.text = displayName;
                          _emailController.text = displayEmail;

                          showDialog(
                            context: context,
                            builder: (context) => StatefulBuilder(
                              builder: (context, setDialogState) {
                                return AlertDialog(
                                  title: const Text("تعديل البيانات الشخصية"),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        buildTextField("ادخل اسمك", "الاسم", controller: _nameController),
                                        buildTextField("ادخل بريدك الإلكتروني", "البريد الإلكتروني", controller: _emailController),
                                        buildTextField(
                                          "ادخل حسابك البنكي",
                                          "الحساب البنكي",
                                          isPassword: true,
                                          isVisible: isBankVisible,
                                          onEyePressed: () {
                                            setDialogState(() {
                                              isBankVisible = !isBankVisible;
                                            });
                                          },
                                          controller: _bankController,
                                        ),
                                        buildTextField(
                                          "ادخل راتبك الشهري",
                                          "الراتب الشهري",
                                          isPassword: true,
                                          isVisible: isSalaryVisible,
                                          onEyePressed: () {
                                            setDialogState(() {
                                              isSalaryVisible = !isSalaryVisible;
                                            });
                                          },
                                          controller: _salaryController,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
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
                                                setDialogState(() {
                                                  selectedCountry = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: const Text("إلغاء", style: TextStyle(color: Colors.black)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () async {
                                        setState(() {
                                          displayName = _nameController.text;
                                          displayEmail = _emailController.text;
                                          displayCountry = selectedCountry ?? "البلد";
                                        });

                                        // حفظ البيانات في SharedPreferences
                                        SharedPreferences prefs = await SharedPreferences.getInstance();
                                        await prefs.setString("name", _nameController.text);
                                        await prefs.setString("email", _emailController.text);
                                        await prefs.setString("country", selectedCountry ?? "البلد");
                                        await prefs.setString("bankAccount", _bankController.text);
                                        await prefs.setString("salary", _salaryController.text);

                                        Navigator.of(context).pop();
                                      },
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStateProperty.all(const Color(0xFF606676)),
                                      ),
                                      child: const Text("حفظ", style: TextStyle(color: Colors.black)),
                                    ),
                                  ],
                                );
                              },
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFEF3E2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: const Text(
                          "تعديل",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -75,
                  left: MediaQuery.of(context).size.width * .25,
                  child: const CircleAvatar(
                    radius: 85,
                    backgroundColor: Color(0xFFBEC6A0),
                    child: CircleAvatar(
                      radius: 75,
                      backgroundImage: AssetImage("assets/images/slogan.gif"),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
