import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/landscape_home_page.dart';
import 'package:tripeaks_neue/pages/home_page/portrait_home_page.dart';
import 'package:tripeaks_neue/widgets/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        drawerScrimColor: Colors.transparent,
        drawer: Actions(
          actions: <Type, Action<Intent>>{
            NewGameIntent: NewGameAction(),
            NavigateToSettingsIntent: NavigateToSettingsAction(),
          },
          child: HomePageDrawer(),
        ),
        body: Builder(
          builder: (context) {
            return size.width > size.height ? const LandscapeHomePage() : const PortraitHomePage();
          },
        ),
      ),
    );
  }
}
