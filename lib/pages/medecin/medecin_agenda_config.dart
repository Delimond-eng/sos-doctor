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
  @override
  _MedecinAgendaConfigPageState createState() =>
      _MedecinAgendaConfigPageState();
}

class _MedecinAgendaConfigPageState extends State<MedecinAgendaConfigPage> {
  String selectedDate = "";
  String timeStart = "";
  String timeEnd = "";

  @override
  Widget build(BuildContext context) {
    return PickupLayout(
      uid: storage.read("medecin_id").toString(),
      scaffold: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/shapes/bg3p.png"),
                  fit: BoxFit.cover)),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [primaryColor.withOpacity(.8), Colors.white10],
              stops: const [0.1, 0.9],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )),
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
                    color: Colors.white,
                    shadows: [
                      const Shadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 2),
                      )
                    ],
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
                          setState(() {
                            timeStart = time.format(context);
                          });
                        }
                        print(timeStart);
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
                          TimeOfDay time = await getShowTimePicker(context);
                          if (time != null) {
                            setState(() {
                              timeEnd = time.format(context);
                            });
                          }
                          print(timeEnd);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                StandardBtn(
                  label: "Configurer",
                  onPressed: () async {
                    if (selectedDate.isEmpty) {
                      Get.snackbar(
                        "Avertissement !",
                        "vous devez sélectionner une date pour configurer votre agenda!",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: Colors.amber[900],
                        maxWidth: MediaQuery.of(context).size.width - 4,
                        borderRadius: 2,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }

                    if (timeStart.isEmpty || timeEnd.isEmpty) {
                      Get.snackbar(
                        "Avertissement !",
                        "vous devez spécifier une heure du début et celle de la fin!",
                        snackPosition: SnackPosition.TOP,
                        colorText: Colors.white,
                        backgroundColor: Colors.amber[900],
                        maxWidth: MediaQuery.of(context).size.width - 4,
                        borderRadius: 20,
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
                      medecinController.refreshDatas();
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
                    borderRadius: BorderRadius.circular(10.0),
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
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 14.0),
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
              borderRadius: BorderRadius.circular(20.0),
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
                    color: primaryColor,
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
