import 'package:flutter/material.dart';
import '../widgets/base_page.dart';
import '../theme/app_theme.dart';

class MatesPage extends StatelessWidget {
  const MatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Amis",
      body: ListView.builder(

        itemBuilder: (BuildContext context, int index) {  },
      ),
    );
  }
}

