import 'package:flutter/material.dart';
import 'package:mizan/database/constant.dart';
import 'package:mizan/database/sqflite.dart';
import 'package:mizan/widgets/widgets.dart';

class InstallmentsScreen extends StatefulWidget {
  const InstallmentsScreen({super.key});

  @override
  State<InstallmentsScreen> createState() => _InstallmentsScreenState();
}

class _InstallmentsScreenState extends State<InstallmentsScreen> {
  bool isNoted = false;
  final TextEditingController amountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  List<Map<String, dynamic>> installments =
      []; // لتخزين الأقساط من قاعدة البيانات

  @override
  void initState() {
    super.initState();
    _loadInstallments(); // تحميل الأقساط عند بداية الشاشة
  }

  // دالة لتحميل الأقساط من قاعدة البيانات
  _loadInstallments() async {
    final dbHelper = DBHelper();
    final data = await dbHelper.getInstallments();
    setState(() {
      installments = data;
      isNoted = installments.isNotEmpty;
    });
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
    dateController.dispose();
    noteController.dispose();
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
                      "في هذه الغرفة يتم عرض أو إضافة أو حذف الأقساط الملتم بها حالياً",
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
          const SizedBox(height: 15),
          isNoted ? buildTable() : buildImage(context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor3,
        child: const Icon(Icons.add, color: Colors.black),
        onPressed: () {
          showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: Text(
                    "إضافة أقساط جديدة",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontStyle3,
                    ),
                  ),
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.45,
                    child: Column(
                      children: [
                        TextField(
                          controller: amountController,
                          decoration: InputDecoration(
                            label: Text(
                              "القسط الشهري",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: kfontStyle3,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: dateController,
                          decoration: InputDecoration(
                            label: Text(
                              "الميعاد",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: kfontStyle3,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: noteController,
                          decoration: InputDecoration(
                            label: Text(
                              "ملاحظات",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: kfontStyle3,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (amountController.text.isNotEmpty &&
                                    dateController.text.isNotEmpty &&
                                    noteController.text.isNotEmpty) {
                                  final dbHelper = DBHelper();
                                  dbHelper.insertInstallment({
                                    'amount': amountController.text,
                                    'date': dateController.text,
                                    'note': noteController.text,
                                  });
                                  _loadInstallments(); // تحميل الأقساط بعد الإضافة
                                  Navigator.of(context).pop();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor3,
                              ),
                              child: Text(
                                "إضافة",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: kfontStyle3,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "إلغاء",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: kfontStyle3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
          );
        },
      ),
    );
  }


  Widget buildTable() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Table(
          border: TableBorder.all(width: 2),
          defaultColumnWidth: FixedColumnWidth(120),
          children: [
            const TableRow(
              decoration: BoxDecoration(color: Colors.black12),
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("القسط الشهري", textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("الميعاد", textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("ملاحظات", textAlign: TextAlign.center),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("حذف", textAlign: TextAlign.center),
                ),
              ],
            ),
            ...installments.map(
              (item) => TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item['amount']!, textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item['date']!, textAlign: TextAlign.center),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(item['note']!, textAlign: TextAlign.center),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final dbHelper = DBHelper();
                      await dbHelper.deleteInstallment(item['id']);
                      _loadInstallments(); // تحميل الأقساط بعد الحذف
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
