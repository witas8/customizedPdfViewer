import 'package:flutter/material.dart';
import 'package:pdfx_viewer/utils/constants.dart';
import 'package:pdfx_viewer/utils/themes_handler.dart';
import 'package:provider/provider.dart';

class AppBarToggle extends StatelessWidget implements PreferredSizeWidget {
  const AppBarToggle({super.key});

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
      actions: const [
        ChangeThemeButtonWidget(),
      ],
      centerTitle: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
    );
  }
}

class ChangeThemeButtonWidget extends StatelessWidget {
  const ChangeThemeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
      activeColor: Colors.grey.shade600,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
      },
    );
  }
}
