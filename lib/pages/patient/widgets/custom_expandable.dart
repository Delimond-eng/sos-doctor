import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

import '../../../index.dart';

class CustomAccordion extends StatelessWidget {
  final Widget child;
  final String title;
  final bool isExpanded;

  const CustomAccordion(
      {Key key, this.title, this.child, this.isExpanded = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: isExpanded,
      child: ScrollOnExpand(
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                tapBodyToExpand: true,
                tapBodyToCollapse: true,
                hasIcon: false,
              ),
              header: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Colors.blue.withOpacity(.8),
                    Colors.blue[800].withOpacity(.8)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
                  borderRadius: BorderRadius.circular(2.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(.4),
                      blurRadius: 12.0,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          title.capitalizeFirst,
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
                      theme: const ExpandableThemeData(
                        expandIcon: CupertinoIcons.chevron_down,
                        collapseIcon: CupertinoIcons.chevron_up,
                        iconColor: Colors.white,
                        iconSize: 15.0,
                        iconRotationAngle: math.pi / 2,
                        iconPadding: EdgeInsets.only(right: 15),
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
