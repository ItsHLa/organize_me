import 'package:flutter/material.dart';

const Icon taskComplete = Icon(Icons.task_alt_outlined);
const Icon taskOngoing = Icon(Icons.pause_circle_outline_outlined);
const Icon taskPending = Icon(Icons.restart_alt);

const Icon darkModeOn = Icon(Icons.wb_sunny_outlined);
const Icon darkModeOff = Icon(Icons.nightlight_outlined);
const Icon waterBill = Icon(
  Icons.water_drop,
  color: Color.fromRGBO(7, 144, 166, 1),
);
const Icon electricBill = Icon(
  Icons.electric_bolt,
  color: Color.fromRGBO(219, 200, 109, 1),
);
const Icon telecomBill = Icon(
  Icons.call_end,
  color: Color.fromRGBO(109, 124, 65, 1),
);

const Color deepPurple = Colors.deepPurple;

// const Color appcolor = Color.fromRGBO(109, 128, 160,1);
const Color blue = Color.fromRGBO(7, 144, 166, 1);
const Color red = Color.fromRGBO(194, 100, 101, 1);
const Color yellow = Color.fromRGBO(219, 200, 109, 1);
const Color green = Color.fromRGBO(109, 124, 65, 1);

RegExp electricRegex = RegExp(
    r'\D+(\d+\.?\d*)\D+الكهرباء\D+(\d+\.?\d*)\D+(\d+)\D+(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\D+: ([\u0621-\u064A]+)\D+(\d+)\D+(\d+)\D+(s\d+)');

Map<String, int> electricRegexGroups = {
  'payment amount': 1,
  'commission amount': 2,
  'invoice number': 3,
  'date': 4,
  'gov': 5,
  'billing number': 6,
  'subscription number': 7,
  'operation number': 8
};

RegExp waterRegex = RegExp(
    r'\D+(\d+\.?\d*)\D+المياه\D+(\d+\.?\d*)\D+(\d+_\d+)\D+(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\D+: ([\u0621-\u064A]+)\D+(\d+)\D+(\d+)\D+(s\d+)');

Map<String, int> waterRegexGroups = {
  'payment amount': 1,
  'commission amount': 2,
  'receipt number': 3,
  'date': 4,
  'gov': 5,
  'barcode number': 6,
  'counter number': 7,
  'operation number': 8
};

RegExp telecomRegex = RegExp(
    r'\D+(\d+\.?\d*)\D+السورية للاتصالات\D+(\d+\.?\d*)\D+(\d+)\D+(\d{2}/\d{2}/\d{4} \d{2}:\d{2})\Dرقم الهاتف الثابت/ البريد الإلكتروني: (\S+@\S+\.\S+|\d+)\D+(s\d+)');

Map<String, int> telecomRegexGroups = {
  'payment amount': 1,
  'commission amount': 2,
  'invoice number': 3,
  'date': 4,
  'phone number/email': 5,
  'operation number': 6
};
