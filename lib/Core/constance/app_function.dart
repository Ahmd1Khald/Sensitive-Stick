import 'package:flutter/materiallors.dart';

class AppFunctions {
  static void pushTo({required context, required Widget screen}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       return SharedAxisTransition(
    //         transitionType: SharedAxisTransitionType.horizontal,
    //         secondaryAnimation: secondaryAnimation,
    //         animation: animation,
    //         child: child,
    //       );
    //     },
    //     transitionDuration: const Duration(seconds: 1),
    //     barrierColor: Colors.black,
    //     pageBuilder: (context, animation, secondaryAnimation) {
    //       return screen;
    //     },
    //   ),
    // );
  }
}
