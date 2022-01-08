import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBtn extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final String label;
  final Color color;
  const CustomBtn({
    Key key,
    this.onPressed,
    this.icon,
    this.label,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/vector/undraw_doctor_kw5l.png"),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: (color == null)
              ? Colors.blue[900].withOpacity(.8)
              : color.withOpacity(.8),
          borderRadius: BorderRadius.zero,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.4),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.zero,
          child: InkWell(
            borderRadius: BorderRadius.zero,
            onTap: onPressed,
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      icon,
                      size: 18.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
