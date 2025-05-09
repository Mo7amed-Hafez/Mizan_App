import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mangingscreen extends StatefulWidget {
  const Mangingscreen({super.key});

  @override
  State<Mangingscreen> createState() => _MangingscreenState();
}

class _MangingscreenState extends State<Mangingscreen> {

  String displaySalary = "";


  @override
  void initState() {
    super.initState();
    _loadUserData();
  }
  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displaySalary = prefs.getString("salary") ?? "اسم المستخدم";
    });
  }
  

  @override
  Widget build(BuildContext context) {
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
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/logo (2).png"),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 25),
                  Container(
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.topRight,
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
                    child: const Text(
                      "في هذة الصفحة يتم عرض افضل نسبه لتنظيم المصروفات من خلال مرتبك",
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
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.45,
            height: MediaQuery.of(context).size.height * 0.12,
            decoration: BoxDecoration(
              color: kPrimaryColor4,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              displaySalary,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: kfontStyle1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final item = dataList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildContPercent(
                    textContainer: item["title"],
                    percent: item["percent"],
                    context: context,
                    rowItems: List<Map<String, String>>.from(item["items"]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildContPercent({
  required String textContainer,
  required double percent,
  required BuildContext context,
  required List<Map<String, String>> rowItems,
}) {
  return Container(
    padding: const EdgeInsets.all(5),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width * 0.47,
    height: MediaQuery.of(context).size.height * 0.6,
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: kPrimaryColor2, width: 2),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          textContainer,
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontFamily: kfontStyle3,
          ),
        ),
        const SizedBox(height: 10),
        CircularPercentIndicator(
          radius: 40,
          lineWidth: 5,
          percent: percent,
          center: Text(
            "${(percent * 100).toInt()}%",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          progressColor: kPrimaryColor3,
          backgroundColor: kPrimaryColor2,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        const SizedBox(height: 10),
        ...rowItems.map(
          (item) => buildRowContainer(
            textRow: item['text']!,
            imagePath: item['image']!,
          ),
        ),
      ],
    ),
  );
}

Widget buildRowContainer({required String textRow, required String imagePath}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(radius: 8, backgroundImage: AssetImage(imagePath)),
        const SizedBox(width: 5),
        Text(
          textRow,
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontFamily: kfontStyle3,
          ),
        ),
      ],
    ),
  );
}
