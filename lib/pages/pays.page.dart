import 'package:flutter/material.dart';
import '../widgets/base_page.dart';
import '../theme/app_theme.dart';

class PaysPage extends StatelessWidget {
  const PaysPage({super.key});

  @override
  Widget build(BuildContext context) {


    return BasePage(
      title: "Pays",
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return null;
        },

      ),
    );
  }
}
