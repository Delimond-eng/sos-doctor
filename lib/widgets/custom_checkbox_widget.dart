import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sos_docteur/constants/style.dart';

class CostumChexkBox extends StatelessWidget {
  final bool value;
  final Function onChanged;
  final String title;
  final bool hasColored;
  const CostumChexkBox({
    Key key,
    this.value = false,
    this.onChanged,
    this.title,
    this.hasColored = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onChanged,
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(5.0),
        decoration: (hasColored)
            ? BoxDecoration(
                color: (value) ? Colors.blue[200] : Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: (hasColored)
                    ? [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 12.0,
                          offset: const Offset(0, 3),
                        )
                      ]
                    : null,
              )
            : const BoxDecoration(
                color: Colors.transparent,
              ),
        child: Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.0,
                  color: Colors.blue[800],
                ),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(.3),
                    blurRadius: 12.0,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Container(
                height: 18.0,
                width: 18.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: (value)
                      ? LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.blue[800],
                          ],
                        )
                      : const LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white,
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Flexible(
              child: Text(
                title,
                style: (hasColored)
                    ? GoogleFonts.lato(
                        letterSpacing: 1.0,
                        color: (value) ? Colors.white : Colors.black87,
                        fontSize: 14.0,
                        fontWeight: (value) ? FontWeight.w600 : FontWeight.w400,
                      )
                    : GoogleFonts.lato(
                        letterSpacing: 1.0,
                        color: primaryColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
