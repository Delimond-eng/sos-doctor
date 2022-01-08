import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

var style1 = GoogleFonts.lato;
var style2 = GoogleFonts.mulish;

var primaryColor = Colors.blue[900];
var defaultRadius = BorderRadius.circular(20.0);

getShowTimePicker(BuildContext context) {
  return showTimePicker(
      context: context,
      initialEntryMode: TimePickerEntryMode.input,
      initialTime: const TimeOfDay(hour: 8, minute: 30));
}

String dateFromString(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(date);
  return formatted;
}

String removeAccent(String str) {
  var withDia =
      'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
  var withoutDia =
      'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

  for (int i = 0; i < withDia.length; i++) {
    str = str.replaceAll(withDia[i], withoutDia[i]);
  }
  return str;
}

DateTime strTodate(String date) {
  final DateFormat formatter = (date.contains("-"))
      ? DateFormat('dd-MM-yyyy')
      : DateFormat('dd/MM/yyyy');
  DateTime d = formatter.parse(date);
  return d;
}

String strDateLong(String value) {
  var date = strTodate(value);
  String converted = DateFormat.yMMMd().format(date);
  return converted;
}

String strDateLongFr(String value) {
  var date = strTodate(value);
  String converted = DateFormat.yMMMd("fr_FR").format(date);
  return converted;
}

List<String> strSpliter(String date) {
  var strList = date.split(RegExp(r"[,| ]"));
  return strList;
}

bool hasPasswordValidated(String value) {
  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

showDateBox(context) async {
  var date = await showDatePicker(
    locale: const Locale("fr", "FR"),
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1950),
    lastDate: DateTime(2050),
    initialDatePickerMode: DatePickerMode.year,
  );
  return date;
}

String truncateString(String text, int length, {bool pointed = false}) {
  return (text.length >= length)
      ? ((pointed)
          ? text.substring(0, length) + "..."
          : text.substring(0, length))
      : text;
}

/*Swiper(
    itemCount: 5,
    itemBuilder: (_, index){
      return Banner();
    },
    itemWidth: MediaQuery.of(context).size.width,
    itemHeight: 220.0,
    layout: SwiperLayout.TINDER,
    scale: 5,
    curve: Curves.easeInOutCubic,
    autoplay: true,
  physics: const BouncingScrollPhysics(),
  fade: 5,
  duration: 1000,
  autoplayDelay: 1000
),*/
