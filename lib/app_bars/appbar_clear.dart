import 'package:flutter/material.dart';
import 'package:pdfx_viewer/utils/constants.dart';

class AppBarClear extends StatelessWidget implements PreferredSizeWidget {
  const AppBarClear({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(55);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        Constants.appBarTitle,
        style: TextStyle(
          color: Constants.txtColor,
        ),
      ),
      automaticallyImplyLeading: false,
      centerTitle: true,
      elevation: 0.0,
    );
  }
}
