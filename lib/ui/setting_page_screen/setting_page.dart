import 'package:bloc_VIDFLIX/dialoge/policy_dialogue.dart';
import 'package:bloc_VIDFLIX/dialoge/termsandconditions.dart';
import 'package:bloc_VIDFLIX/ui/splash_page/splash.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

bool isDarkMode = false;
Color? mainBGColor = Color.fromARGB(255, 26, 26, 26);
Color? allTextColor = Colors.white;
Color? bottomNavColor = Colors.black;
Color? AppBarColor = Colors.black;
Color? containerColor = Colors.black;

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return settingOption();
  }
}

class settingOption extends StatefulWidget {
  const settingOption({super.key});

  @override
  State<settingOption> createState() => _settingOptionState();
}

class _settingOptionState extends State<settingOption> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBGColor,
      appBar: AppBar(
        backgroundColor: AppBarColor,
        title: Text("Setting"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: ListView(
          children: [
            ListTile(
              leading: Text(
                'Light Theme',
                style: TextStyle(
                    color: allTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              trailing: Padding(
                padding: const EdgeInsets.only(
                  right: 0,
                ),
                child: SizedBox(
                  width: 30,
                  child: Switch(
                      value: isDarkMode,
                      onChanged: (value) {
                        if (isDarkMode == true) {
                          isDarkMode = false;
                          mainBGColor = Color.fromARGB(255, 26, 26, 26);
                          allTextColor = Colors.white;
                          bottomNavColor = Colors.black;
                          AppBarColor = Colors.black;
                          containerColor = Colors.black;
                        } else {
                          isDarkMode = true;
                          mainBGColor = Color.fromARGB(255, 250, 250, 250);
                          allTextColor = Colors.black;
                          bottomNavColor = Color.fromARGB(255, 128, 118, 118);
                          AppBarColor = Colors.grey;
                          containerColor = Colors.white;
                        }

                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const Splashscreen(),
                            ),
                            (route) => true);
                      }),
                ),
              ),
            ),
            ListTile(
              onTap: () async {
                const urllink = 'app.VIDFLIX.video_player';
                await Share.share(urllink);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
              title: Text('Share App',
                  style: TextStyle(
                      fontSize: 20,
                      color: allTextColor,
                      fontWeight: FontWeight.w500)),
              trailing: Icon(
                Icons.share,
                color: allTextColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TermsAndCondtions(
                        mdFileName1: 'terms_and_condition.md');
                  },
                );
              },
              leading: Text('Terms and Conditions',
                  style: TextStyle(
                      fontSize: 20,
                      color: allTextColor,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PrivacyDialogue(mdFileName: 'privacy_policy.md');
                  },
                );
              },
              leading: Text('Privacy Policy',
                  style: TextStyle(
                      fontSize: 20,
                      color: allTextColor,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
