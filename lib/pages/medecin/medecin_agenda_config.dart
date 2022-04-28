import 'dart:math';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_docteur/constants/controllers.dart';
import 'package:sos_docteur/constants/style.dart';
import 'package:sos_docteur/models/index.dart';
import 'package:sos_docteur/services/medecins_api_services/med_api.dart';
import 'package:sos_docteur/utilities/utilities.dart';
import 'package:sos_docteur/video_calls/pages/pickup_layout.dart';
import 'package:sos_docteur/widgets/standard_button.dart';

class MedecinAgendaConfigPage extends StatefulWidget {
  const MedecinAgendaConfigPage({Key key}) : super(key: key);

  @override
  _MedecinAgendaConfigPageState createState() =>
      _MedecinAgendaConfigPageState();
}

class _MedecinAgendaConfigPageState extends State<MedecinAgendaConfigPage> {
  String selectedDate = "";
  String timeStart = "";
  String timeEnd = "";
  int timestampStart;
  int timestampEnd;

  @override
  void initState() {
    super.initState();
  }

  initDate() {
    var dateNow =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    setState(() {
      selectedDate = dateFromString(dateNow);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("medecin_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/shapes/bg4p.png"),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(color: Colors.white.withOpacity(.8)),
            child: SafeArea(
                child: ListView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              physics: const ScrollPhysics(),
              children: [
                _header(),
                SizedBox(height: MediaQuery.of(context).size.height / 8),
                Text(
                  "Veuillez configurer votre agenda en spécifiant vos heures de disponibilité !",
                  style: GoogleFonts.lato(
                    fontSize: 18.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "Sélectionnez une Date",
                  style: style1(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                    color: Colors.pink,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: DatePicker(
                    DateTime.now(),
                    height: 100.0,
                    width: 80.0,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: primaryColor,
                    selectedTextColor: Colors.white,
                    locale: "FR",
                    dateTextStyle: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[800],
                    ),
                    dayTextStyle: GoogleFonts.lato(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.blue[800],
                    ),
                    monthTextStyle: GoogleFonts.lato(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue[800]),
                    onDateChange: (date) {
                      setState(() {
                        selectedDate = dateFromString(date);
                      });
                      print(selectedDate);
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: TimePickerBox(
                      hintText: "8:00 PM",
                      selectedTime: timeStart,
                      title: "Heure du début",
                      onShowTime: () async {
                        TimeOfDay time = await getShowTimePicker(context);
                        if (time != null) {
                          final now = DateTime.now();
                          var timeNow = DateTime(now.year, now.month, now.day,
                              time.hour, time.minute);
                          setState(() {
                            timeStart = time.format(context);
                            timestampStart = timeNow.microsecondsSinceEpoch;
                          });
                        }
                        print(timestampStart);
                      },
                    )),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: TimePickerBox(
                        hintText: "12:00 PM",
                        selectedTime: timeEnd,
                        title: "Heure de la fin",
                        onShowTime: () async {
                          TimeOfDay time =
                              await getShowTimePicker(context, hours: [12, 00]);
                          if (time != null) {
                            final now = DateTime.now();
                            var timeNow = DateTime(now.year, now.month, now.day,
                                time.hour, time.minute);
                            setState(() {
                              timeEnd = time.format(context);
                              timestampEnd = timeNow.microsecondsSinceEpoch;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                StandardBtn(
                  radius: 5.0,
                  color: Colors.orange[800],
                  label: "Configurer",
                  onPressed: () async {
                    if (timeStart.isEmpty && timeEnd.isEmpty) {
                      Get.snackbar(
                        "Champs non remplis !",
                        "vous devez choisir une heure du début et une heure de la fin!",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: Colors.black87,
                        maxWidth: MediaQuery.of(context).size.width - 4,
                        borderRadius: 5.0,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }
                    if (timestampStart >= timestampEnd) {
                      Get.snackbar(
                        "Heures invalides !",
                        "L'heure du début doit être inférieure à l'heure de la fin!",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: Colors.black87,
                        maxWidth: MediaQuery.of(context).size.width - 4,
                        borderRadius: 5.0,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }
                    Xloading.showLottieLoading(context);
                    final agenda = AgendaConfig(
                      startHour: timeStart,
                      endHour: timeEnd,
                      date: selectedDate,
                    );
                    var res = await MedecinApi.configAgenda(agenda: agenda);
                    if (res != null) {
                      Xloading.dismiss();
                      Get.snackbar(
                        "Succès !",
                        "votre agenda a été configuré avec succès !!",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: Colors.green[700],
                        maxWidth: MediaQuery.of(context).size.width - 4,
                        borderRadius: 2,
                        duration: const Duration(seconds: 3),
                      );
                      setState(() {
                        timeStart = "";
                        timeEnd = "";
                      });
                      await medecinController.refreshDatas();
                      Get.back();
                    } else {
                      Get.snackbar(
                        "Echec !",
                        "cette action n'a pas aboutie!,\nveuillez réessayer ultérieurement svp!",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: Colors.green[700],
                        maxWidth: MediaQuery.of(context).size.width - 4,
                        borderRadius: 2,
                        duration: const Duration(seconds: 3),
                      );
                      Xloading.dismiss();
                      return;
                    }
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(.3),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: const Center(
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                  )),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Configuration agenda",
              style: style1(
                fontWeight: FontWeight.w800,
                fontSize: 18.0,
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TimePickerBox extends StatelessWidget {
  final Function onShowTime;
  final String selectedTime;
  final String hintText;
  final String title;
  const TimePickerBox(
      {this.onShowTime, this.selectedTime, this.hintText, this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: style1(fontWeight: FontWeight.w500, fontSize: 15.0),
          ),
        ),
        GestureDetector(
          onTap: onShowTime,
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              border: Border.all(color: primaryColor, width: 1),
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.grey[100].withOpacity(.5),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 12.0,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (selectedTime.isEmpty)
                    Text(
                      hintText,
                      style: style1(
                          color: Colors.grey[600],
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        selectedTime,
                        style: style1(
                          color: Colors.blue[900],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  Icon(
                    CupertinoIcons.time_solid,
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)]
                        .shade900,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
