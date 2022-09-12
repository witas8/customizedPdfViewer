import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx_viewer/screens/document_viewer.dart';
import 'package:pdfx_viewer/screens/login_page.dart';
import 'package:pdfx_viewer/screens/machine_selector.dart';

abstract class MyRoutes {
  static const String login = '/';
  static const String machine = '/machine';
  static const String document = '/document';

  static const Widget screen1 = LoginPage();
  static const Widget screen2 = MachineSelector();
  static const Widget screen3 = DocumentViewer();

  static Map<String, Widget Function(BuildContext)> mobileWindowsRoutes = {
    MyRoutes.login: (context) => screen1,
    MyRoutes.machine: (BuildContext context) => screen2,
    MyRoutes.document: (BuildContext context) => screen3
  };

  static final webPages = [
    GetPage(
      name: login,
      page: () => screen1,
    ),
    GetPage(
      name: machine,
      page: () => screen2,
    ),
    GetPage(
      name: document,
      page: () => screen3,
    ),
  ];
}

// class AppRouterDelegate extends GetDelegate {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       onPopPage: (route, result) => route.didPop(result),
//       pages: currentConfiguration != null
//           ? [currentConfiguration!.currentPage!]
//           : [GetNavConfig.fromRoute(MyRoutes.login)!.currentPage!],
//     );
//   }
// }
