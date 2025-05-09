import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // علشان ادخل  ارقام بس
import 'package:mizan/database/constant.dart';

class Dolarscreen extends StatefulWidget {
  const Dolarscreen({super.key});

  @override
  State<Dolarscreen> createState() => _DolarscreenState();
}

class _DolarscreenState extends State<Dolarscreen> {
  String? selectedCurrencyMoney;
  TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double? convertedAmount;

  void convertCurrency() {
    if (_formKey.currentState!.validate() && selectedCurrencyMoney != null) {
      double enteredAmount = double.parse(amountController.text);
      double rate = moneyFelow[selectedCurrencyMoney]!;
      setState(() {
        convertedAmount = enteredAmount * rate;
      });
    }
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
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(9.8),
          child: Column(
            children: [
              //  الصورة + الترحيب
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage("assets/images/logo (2).png"),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        padding: const EdgeInsets.all(5),
                        alignment: Alignment.topRight,
                        height: 100,
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
                          "في هذه الغرفة يمكنك تحويل العملات الي قيمتها الدولاريه",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            fontFamily: kfontStyle3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              //  اختيار العملة
              Row(
                children: [
                  const Text(
                    "اختر العملة المراد تحويلها:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    icon: const Icon(Icons.arrow_downward_outlined),
                    dropdownColor: kPrimaryColor3,
                    value: selectedCurrencyMoney,
                    hint: const Text("اختر"),
                    items:
                        moneyFelow.keys.map((country) {
                          return DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCurrencyMoney = value;
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 15),

              //  حقل إدخال المبلغ
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "ادخل المبلغ بالدولار",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'من فضلك ادخل المبلغ';
                    }
                    if (double.tryParse(value) == null) {
                      return 'ادخل رقم صالح';
                    }
                    return null;
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ✅ زر التحويل
              ElevatedButton(
                onPressed: convertCurrency,
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "تحويل",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    fontFamily: kfontStyle3,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ عرض النتيجة
              if (convertedAmount != null)
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    "$convertedAmount ${selectedCurrencyMoney!.split(' ').last}",
                    maxLines: 2,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: kfontStyle3,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
