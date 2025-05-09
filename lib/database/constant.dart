import 'package:flutter/material.dart';

const  kPrimaryColor = Color(0xFFFEF3E2);
const kPrimaryColor2 = Color(0xFFBEC6A0);
const kPrimaryColor3 = Color(0xFF708871);
const kPrimaryColor4 = Color(0xFF606676);
const kfontStyle1 = "Handjet";
const kfontStyle2 = "Lemonada";
const kfontStyle3 = "ReadexPro";
const kfontStyle4 = "ReemKufi";
const kfontStyle5 = "Gulzar";
List<String> countries = [
  'مصر',
  'السعودية',
  'الامارات',
  'البحرين',
  'الكويت',
  'قطر',
  'تونس',
  'سوريا',
  'الجزائر',
  'فلسطين',
  'عُمان',
  'السودان',
  'لبنان',
  'ليبيا',
  'موريتانيا',
  'العراق',
  'الاردن',
  'الصومال',
  'جيبوتى',
  'جزر القمر',
  'المغرب',
];

List<String> items = [
  'Egypt (EGP)',
  'Saudi Arabia (SAR)',
  'UAE (AED)',
  'Bahrain (BHD)',
  'Kuwait (KWD)',
  'Qatar (QAR)',
  'Tunisia (TND)',
  'Syria (SYP)',
  'Algeria (DZD)',
  'Palestine (ILS)',
  'Oman (OMR)',
  'Sudan (SDG)',
  'Lebanon (LBP)',
  'Libya (LYD)',
  'Mauritania (MRU)',
  'Iraq (IQD)',
  'Jordan (JOD)',
  'Somalia (SOS)',
  'Djibouti (DJF)',
  'Comoros (KMF)',
  'Morocco (MAD)',
  'Germany (EUR)',
  'Japan (JPY)',
  'England (GBP)',
  'Switzerland (CHF)',
  'Australia (AUD)',
];

Map<String, double> moneyFelow = {
  'Egypt (EGP)': 48.44,
  'Saudi Arabia (SAR)': 3.75,
  'UAE (AED)': 3.67,
  'Bahrain (BHD)': 0.3770,
  'Kuwait (KWD)': 0.31,
  'Qatar (QAR)': 3.65,
  'Tunisia (TND)': 3.04,
  'Syria (SYP)': 14750,
  'Algeria (DZD)': 132.50,
  'Palestine (ILS)': 3.65,
  'Oman (OMR)': 0.39,
  'Sudan (SDG)': 601.50,
  'Lebanon (LBP)': 89500.00,
  'Libya (LYD)': 4.76,
  'Mauritania (MRU)': 39.73,
  'Iraq (IQD)': 1310.00,
  'Jordan (JOD)': 0.71,
  'Somalia (SOS)': 571,
  'Djibouti (DJF)': 177.94,
  'Comoros (KMF)': 443.55,
  'Morocco (MAD)': 9.72,
  'Germany (EUR)': 0.89,
  'Japan (JPY)': 143.28,
  'England (GBP)': 1.4847,
  'Switzerland (CHF)': 0.8435,
  'Australia (AUD)': 1.48,
};

List<Map<String, dynamic>> dataList = [
    {
      "title": "المصروفات الاساسية",
      "percent": 0.5,
      "items": [
        {"text": "فواتير الكهرباء و الماء", "image": "assets/images/l1.png"},
        {"text": "مصاريف التعليم", "image": "assets/images/l2.png"},
        {"text": "الرعاية الصحية", "image": "assets/images/l3.png"},
        {"text": "المواصلات", "image": "assets/images/l4.png"},
        {"text": "الاتصلات", "image": "assets/images/l44.png"},
      ],
    },
    {
      "title": "المصروفات الشخصية المتغيرة",
      "percent": 0.3,
      "items": [
        {"text": "التسوق", "image": "assets/images/l5.png"},
        {"text": "الانشطة الترفيهية", "image": "assets/images/l6.png"},
        {"text": "الرحلات", "image": "assets/images/l7.png"},
        {"text": "الهدايا", "image": "assets/images/l8.png"},
      ],
    },
    {
      "title": "الادخار و الاستثمار",
      "percent": 0.2,
      "items": [
        {"text": "زيادة المدخرات", "image": "assets/images/l9.png"},
        {"text": "تعجيل سداد الديون", "image": "assets/images/l10.png"},
        {"text": "حالات الطوارئ", "image": "assets/images/l10.png"},
      ],
    },
  ];