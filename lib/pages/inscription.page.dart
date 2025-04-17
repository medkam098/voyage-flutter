import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../widgets/base_page.dart";
import "../theme/app_theme.dart";

class InscriptionPage extends StatelessWidget {
  final TextEditingController txt_login;
  final TextEditingController txt_password;
  final SharedPreferences? prefs;

  InscriptionPage({super.key, SharedPreferences? prefs})
    : txt_login = TextEditingController(),
      txt_password = TextEditingController(),
      prefs = prefs;
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Inscription",
      showDrawer: false,
      body: Column(
        children: [
          Container(
            padding: AppTheme.paddingMedium,
            child: TextFormField(
              decoration: AppTheme.inputDecoration(
                "Email",
                "Entrer votre email",
                Icons.email,
              ),
              controller: txt_login,
            ),
          ),
          Container(
            padding: AppTheme.paddingMedium,
            child: TextFormField(
              decoration: AppTheme.inputDecoration(
                "Mot de passe",
                "Entrez votre mot de passe",
                Icons.lock,
              ),
              controller: txt_password,
              obscureText: true,
            ),
          ),
          Padding(
            padding: AppTheme.paddingMedium,
            child: ElevatedButton(
              onPressed: () {
                _onInscrire(context); // _ car private
              },
              child: const Text("Inscription"),
            ),
          ),
          Padding(
            padding: AppTheme.paddingMedium,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/authentification');
              },
              child: Text("Authentification", style: AppTheme.linkTextStyle),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onInscrire(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    if (txt_login.text.isNotEmpty && txt_password.text.isNotEmpty) {
      prefs?.setString("login", txt_login.text);
      prefs?.setString("password", txt_password.text);
      prefs?.setBool("connecte", true);
      Navigator.pop(context);
      Navigator.pushNamed(context, '/home');
    } else {
      const snackBar = SnackBar(
        content: Text('Veuillez remplir tous les champs'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
