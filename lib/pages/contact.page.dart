import 'package:flutter/material.dart';
import '../widgets/base_page.dart';
import '../theme/app_theme.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Contact",
      body: ListView.builder(

        itemBuilder: (BuildContext context, int index) {  },
      ),
    );
  }


}
