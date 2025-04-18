import 'package:flutter/material.dart';
import '../widgets/base_page.dart';
import '../theme/app_theme.dart';

class MeteoPage extends StatelessWidget {
  const MeteoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Meteo",
      body: ListView.builder(

        itemBuilder: (BuildContext context, int index) {  },
      ),
    );
  }
}

