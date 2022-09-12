import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdfx_viewer/app_bars/appbar_logout.dart';
import 'package:pdfx_viewer/providers/machine.dart';
import 'package:pdfx_viewer/utils/constants.dart';
import 'package:pdfx_viewer/utils/my_routes.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class MachineSelector extends StatefulWidget {
  const MachineSelector({super.key});

  @override
  State<MachineSelector> createState() => _MachineSelectorState();
}

class _MachineSelectorState extends State<MachineSelector> {
  late Map<String, String> tilesMap;
  late Future<Map<String, String>> _futureTilesMap;

  @override
  void initState() {
    getFutureMap();
    super.initState();
  }

  Future<Map<String, String>> getFutureMap() async {
    return Map.fromIterables(Constants.keys, Constants.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLogout(),
      body: FutureBuilder<Map>(
        future: getFutureMap(),
        builder: (
          BuildContext context,
          AsyncSnapshot<Map> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount:
                    (UniversalPlatform.isDesktop || UniversalPlatform.isWeb)
                        ? 3
                        : 2,
                shrinkWrap: true,
                childAspectRatio:
                    (UniversalPlatform.isDesktop || UniversalPlatform.isWeb)
                        ? 2
                        : 1,
                padding: const EdgeInsets.all(10.0),
                physics: const BouncingScrollPhysics(),
                children: List.generate(Constants.values.length, (index) {
                  return GestureDetector(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: Card(
                          margin: const EdgeInsets.all(10.0),
                          elevation: 4,
                          color: Theme.of(context).primaryColor,
                          child: Center(
                              child: Text(
                            snapshot.data!.keys.elementAt(index),
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 24.0),
                          )),
                        ),
                      ),
                      onTap: () => {
                            context.read<MachineModelProvider>().setValues(
                                snapshot.data!.keys.elementAt(index),
                                snapshot.data!.values.elementAt(index)),
                            kIsWeb
                                //? Get.rootDelegate.toNamed(Routes.document)
                                ? Get.toNamed(MyRoutes.document)
                                : Navigator.pushNamed(
                                    context, MyRoutes.document)
                          });
                }),
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
}
