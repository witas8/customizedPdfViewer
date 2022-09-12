import 'package:flutter/material.dart';
import 'package:pdfx_viewer/providers/machine.dart';
import 'package:pdfx_viewer/screens/document_viewer.dart';
import 'package:pdfx_viewer/screens/login_page.dart';
import 'package:pdfx_viewer/screens/machine_selector.dart';
import 'package:pdfx_viewer/utils/constants.dart';
import 'package:pdfx_viewer/utils/my_routes.dart';
import 'package:pdfx_viewer/utils/themes_handler.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

//tip for opening not secured pdfs:
//1. Go to flutter\bin\cache and remove a file named: flutter_tools.stamp
//2. Go to flutter\packages\flutter_tools\lib\src\web and open the file chrome.dart.
//3. Find '--disable-extensions' remove and add 4.step
//4. Add '--disable-web-security'

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MachineModelProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: MyRoutes.login,
        title: Constants.appBarTitle,
        themeMode: Provider.of<ThemeProvider>(context).themeMode,
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        getPages: MyRoutes.webPages,
        routes: MyRoutes.mobileWindowsRoutes,
      );

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//         create: (BuildContext context) => ThemeProvider(),
//         builder: ((context, child) {
//           final themeProvider = Provider.of<ThemeProvider>(context);
//           return GetMaterialApp(

}
