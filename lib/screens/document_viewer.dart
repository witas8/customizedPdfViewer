import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:pdfx_viewer/app_bars/appbar_logout.dart';
import 'package:internet_file/internet_file.dart';
import 'package:pdfx_viewer/providers/machine.dart';
import 'package:provider/provider.dart';
import 'package:universal_platform/universal_platform.dart';

class DocumentViewer extends StatefulWidget {
  const DocumentViewer({Key? key}) : super(key: key);

  @override
  State<DocumentViewer> createState() => _DocumentViewerState();
}

class _DocumentViewerState extends State<DocumentViewer> {
  int _actualPageNumber = 1, _allPagesCount = 0;
  late String machineName, url;
  late Future<PdfController> _futurePdfController;

  @override
  void initState() {
    _futurePdfController = getFuturePdf();
    super.initState();
  }

  Future<PdfController> getFuturePdf() async {
    return PdfController(
      document: PdfDocument.openData(
          InternetFile.get(context.read<MachineModelProvider>().url)),
      initialPage: _actualPageNumber,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarLogout(),
      body: FutureBuilder<PdfController>(
        future: _futurePdfController,
        builder: (
          BuildContext context,
          AsyncSnapshot<PdfController> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else if (snapshot.hasData) {
              return PdfView(
                controller: snapshot.data!,
                onDocumentLoaded: (document) {
                  setState(() {
                    _allPagesCount = document.pagesCount;
                  });
                },
                onPageChanged: (page) {
                  setState(() {
                    _actualPageNumber = page;
                  });
                },
                scrollDirection: Axis.vertical,
              );
            } else {
              return const Text('Empty data');
            }
          } else {
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FutureBuilder(
          future: _futurePdfController,
          builder: (
            BuildContext context,
            AsyncSnapshot<PdfController> snapshot,
          ) {
            return (UniversalPlatform.isDesktop || UniversalPlatform.isWeb)
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FloatingActionButton(
                            heroTag: "btn_counter_win",
                            onPressed: () {},
                            child: Text("$_actualPageNumber/$_allPagesCount",
                                style: const TextStyle(fontSize: 16))),
                        const SizedBox(width: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FloatingActionButton(
                              heroTag: "btn_up",
                              child: const RotatedBox(
                                  quarterTurns: 1,
                                  child: Icon(Icons.arrow_back_ios_new)),
                              onPressed: () {
                                setState(() {
                                  //_pdfController.animateToPage(0, duration: duration, curve: curve)
                                  snapshot.data!.previousPage(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.ease);
                                });
                              },
                            ),
                            const SizedBox(width: 20.0),
                            FloatingActionButton(
                              heroTag: "btn_down",
                              child: const RotatedBox(
                                  quarterTurns: 3,
                                  child: Icon(Icons.arrow_back_ios_new)),
                              onPressed: () {
                                setState(() {
                                  snapshot.data!.nextPage(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      curve: Curves.ease);
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container(
                    margin: const EdgeInsets.only(right: 12.0),
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                        heroTag: "btn_counter",
                        onPressed: () {},
                        mouseCursor: MouseCursor.uncontrolled,
                        tooltip: "Page number",
                        isExtended: false,
                        child: Text(
                          "$_actualPageNumber/$_allPagesCount",
                          style: const TextStyle(fontSize: 16),
                        )),
                  );
          }),
    );
  }
}
