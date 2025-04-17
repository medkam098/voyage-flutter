import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "../widgets/base_page.dart";
import "../theme/app_theme.dart";

class AuthentificiationPage extends StatelessWidget {
  final TextEditingController txt_login;
  final TextEditingController txt_password;
  final SharedPreferences? prefs;

  AuthentificiationPage({super.key, this.prefs})
    : txt_login = TextEditingController(),
      txt_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: "Authentification",
      showDrawer: false,
      body: Column(
        children: [
          Container(
            padding: AppTheme.paddingMedium,
            child: TextFormField(
              decoration: AppTheme.inputDecoration(
                "Email",
                "Entrez votre email",
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
                _onAuthentifier(context); // _ car private
              },
              child: const Text("Authentifier"),
            ),
          ),
          Padding(
            padding: AppTheme.paddingMedium,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inscription');
              },
              child: Text("Inscription", style: AppTheme.linkTextStyle),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onAuthentifier(BuildContext context) async {
    final preferences = await SharedPreferences.getInstance();
    if (txt_login.text.isNotEmpty && txt_password.text.isNotEmpty) {
      if (txt_login.text == prefs?.getString("login") &&
          txt_password.text == prefs?.getString("password")) {
        prefs?.setBool("connecte", true);
        Navigator.pushNamed(context, '/home');
      } else {
        const snackBar = SnackBar(
          content: Text('Email ou mot de passe incorrect'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      const snackBar = SnackBar(
        content: Text('Veuillez remplir tous les champs'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
