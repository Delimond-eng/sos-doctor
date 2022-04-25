import 'package:flutter/cupertino.dart';
import 'package:sos_docteur/screens/pages/login_page.dart';
import 'package:sos_docteur/screens/pages/register_page.dart';

import '../index.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isSignUpScreen = false;
  bool isLoginScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/shapes/bg4p.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.8),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                AuthButton(
                                  isActive: isLoginScreen,
                                  icon: Icons.login,
                                  label: "Connexion",
                                  onPressed: () {
                                    setState(() {
                                      isLoginScreen = true;
                                      isSignUpScreen = false;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                AuthButton(
                                  icon: CupertinoIcons.person_add_solid,
                                  label: "Créer compte",
                                  isActive: isSignUpScreen,
                                  onPressed: () {
                                    setState(() {
                                      isLoginScreen = false;
                                      isSignUpScreen = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 15.0,
                        child: Image.asset(
                          "assets/icons/ic_icon_transparent.png",
                          height: 100.0,
                          width: 100.0,
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                  if (isLoginScreen)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .10,
                    )
                  else
                    const SizedBox(
                      height: 0,
                    ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                          child: Text(
                            (isLoginScreen)
                                ? "Veuillez vous connecter!"
                                : "Veuillez créer un compte!",
                            style: GoogleFonts.lato(
                              color: Colors.black87,
                              fontWeight: FontWeight.w900,
                              fontSize: 25.0,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        if (isLoginScreen)
                          const LoginPage()
                        else
                          RegisterPage(
                            onBackToLogin: () {
                              setState(() {
                                isLoginScreen = true;
                                isSignUpScreen = false;
                              });
                            },
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButton extends StatelessWidget {
  final Function onPressed;
  final bool isActive;
  final String label;
  final IconData icon;

  const AuthButton(
      {Key key, this.onPressed, this.isActive = false, this.label, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: (isActive) ? primaryColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            blurRadius: 10.0,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(25.0),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(25.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: (isActive) ? Colors.white : primaryColor,
                  size: 12.0,
                ),
                const SizedBox(
                  width: 8.0,
                ),
                Text(
                  label.toUpperCase(),
                  style: GoogleFonts.lato(
                    fontWeight: (!isActive) ? FontWeight.w400 : FontWeight.w600,
                    color: (isActive) ? Colors.white : primaryColor,
                    fontSize: 10.0,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
