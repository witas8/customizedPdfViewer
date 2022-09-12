import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdfx_viewer/providers/machine.dart';
import 'package:pdfx_viewer/utils/my_routes.dart';
import 'package:pdfx_viewer/utils/constants.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AppBarLogout extends StatefulWidget implements PreferredSizeWidget {
  const AppBarLogout({super.key});

  @override
  State<AppBarLogout> createState() => _AppBarLogoutState();

  @override
  Size get preferredSize => const Size.fromHeight(55);
}

class _AppBarLogoutState extends State<AppBarLogout> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MachineModelProvider>(
        builder: (context, itemProviderValue, _) {
      return AppBar(
        title: Text(
          itemProviderValue.name,
          style: TextStyle(
            color: Constants.txtColor,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 25),
          onPressed: () => {
            itemProviderValue.setValues(Constants.appBarTitle, ""),
            Navigator.of(context).pop(),
          },
        ),
        actions: const [LogoutButton()],
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      );
    });
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MachineModelProvider>(
        builder: (context, itemProviderValue, _) {
      return IconButton(
        alignment: Alignment.centerRight,
        onPressed: () {
          itemProviderValue.setValues(Constants.appBarTitle, "");
          kIsWeb
              ? Get.toNamed(MyRoutes.login)
              : Navigator.pushNamed(context, '/');
        },
        icon: const Icon(
          Icons.logout_rounded,
          color: Colors.black,
          size: 26.0,
        ),
      );
    });
  }
}
