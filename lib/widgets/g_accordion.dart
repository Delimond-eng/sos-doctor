import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import '../index.dart';

class GAccordion extends StatelessWidget {
  final Widget child;
  final String title;
  final Color color;
  final IconData cicon;
  final IconData oicon;

  const GAccordion(
      {Key key, this.title, this.child, this.color, this.cicon, this.oicon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: ScrollOnExpand(
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                fadeCurve: Curves.bounceIn,
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: (color == null) ? Colors.blue.withOpacity(.4) : color,
                  borderRadius: BorderRadius.circular(2.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.4),
                      blurRadius: 12.0,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          title.toUpperCase(),
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            fontSize: 14.0,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                    ),
                    ExpandableIcon(
                      theme: ExpandableThemeData(
                        expandIcon:
                            (oicon == null) ? CupertinoIcons.add : oicon,
                        collapseIcon:
                            (cicon == null) ? CupertinoIcons.minus : cicon,
                        iconColor: Colors.white,
                        iconSize: 15.0,
                        iconRotationAngle: math.pi / 2,
                        iconPadding: const EdgeInsets.only(right: 15),
                        hasIcon: false,
                      ),
                    ),
                  ],
                ),
              ),
              collapsed: Container(),
              expanded: child,
            ),
          ],
        ),
      ),
    );
  }
}
