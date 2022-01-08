import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sos_docteur/screens/pages/login_page.dart';
import 'package:sos_docteur/screens/pages/register_page.dart';

import '../index.dart';

class AuthScreen extends StatefulWidget {
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
            image: AssetImage("assets/images/shapes/bg9.png"),
            fit: BoxFit.cover,
          )),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  colors: [
                    primaryColor,
                    primaryColor.withOpacity(.7),
                    Colors.white.withOpacity(.8),
                    Colors.white.withOpacity(.4),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SOS  Docteur",
                                style: style1(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(
                                height: 2.0,
                              ),
                              Shimmer.fromColors(
                                enabled: true,
                                baseColor: Colors.red,
                                highlightColor: Colors.white,
                                child: Text(
                                  "24h/24, 7j/7",
                                  style: style1(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            AuthButton(
                              isActive: isLoginScreen,
                              icon: CupertinoIcons.lock_fill,
                              label: "Connexion",
                              onPressed: () {
                                setState(() {
                                  isLoginScreen = true;
                                  isSignUpScreen = false;
                                });
                              },
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            AuthButton(
                              icon: CupertinoIcons.person_circle_fill,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            (isLoginScreen)
                                ? "Veuillez vous connecter!"
                                : "Veuillez créer un compte!",
                            style: style1(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 25.0,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
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
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: isActive ? Colors.white : Colors.transparent,
                width: 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 14.0,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                label,
                style: style1(
                  fontWeight: (!isActive) ? FontWeight.w400 : FontWeight.w600,
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              )
            ],
          )),
    );
  }
}
