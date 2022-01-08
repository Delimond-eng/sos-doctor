import '../../index.dart';

class ACard extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  const ACard({
    Key key,
    this.icon,
    this.title,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: 120.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.4),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(
                "assets/images/vector/$icon",
                height: 60.0,
                width: 60.0,
                color: Colors.amber[100],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String icon;
  final String title;
  final Color color;
  final Color subColor;
  final Function onPressed;
  const MenuCard({
    Key key,
    this.icon,
    this.title,
    this.color,
    this.subColor,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage("assets/images/shapes/bg2.png"),
            fit: BoxFit.cover,
            scale: 1.5,
          ),
          borderRadius: BorderRadius.circular(5.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.4),
              blurRadius: 12.0,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: color.withOpacity(.8),
            borderRadius: BorderRadius.circular(5.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.4),
                blurRadius: 12.0,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(5.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(5.0),
              onTap: onPressed,
              child: Container(
                height: 120.0,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: SvgPicture.asset(
                        "assets/images/vector/$icon",
                        height: 40.0,
                        width: 40.0,
                        color: subColor,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                        color: subColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*Container(
      child: new Material(
        child: new InkWell(
          onTap: (){print("tapped");},
          child: new Container(
            width: 100.0,
            height: 100.0,
          ),
        ),
        color: Colors.transparent,
      ),
      color: Colors.orange,
    ),*/
