import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/views/settings/widgets/feedback_banner.dart';

import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/settings_text_style.dart';
import '../../app/views/my_in_app_web_view.dart';
import '../widgets/ios_toggle.dart';
import '../widgets/settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isSwitched = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: ConstructorTextStyle.appBar,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.2),
          child: Container(
            height: 0.2,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: size.height * 0.015,
                  ),
                  FeedbackBanner(),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SettingsTile(
                            assetName: 'assets/icons/terms.svg',
                            text: 'Terms of use',
                            action: Row(
                              children: [
                                SvgPicture.asset('assets/icons/arrow.svg')
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyScreenForVIew(
                                      url: 'https://google.com/'),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            indent: 16,
                            endIndent: 10,
                            height: 1.0,
                            thickness: 0.2,
                            color: Colors.grey,
                          ),
                          SettingsTile(
                            assetName: 'assets/icons/privacy.svg',
                            text: 'Privacy Policy',
                            action: SvgPicture.asset('assets/icons/arrow.svg'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyScreenForVIew(
                                      url: 'https://google.com/'),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            indent: 16,
                            endIndent: 10,
                            height: 1.0,
                            thickness: 0.2,
                            color: Colors.grey,
                          ),
                          SettingsTile(
                            assetName: 'assets/icons/support.svg',
                            text: 'Support page',
                            action: SvgPicture.asset('assets/icons/arrow.svg'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyScreenForVIew(
                                      url: 'https://google.com/'),
                                ),
                              );
                            },
                          ),
                        ],
                      )),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SettingsTile(
                            assetName: 'assets/icons/share.svg',
                            text: 'Share with friends',
                            action: Row(
                              children: [
                                SvgPicture.asset('assets/icons/arrow.svg')
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyScreenForVIew(
                                      url: 'https://google.com/'),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            indent: 16,
                            endIndent: 10,
                            height: 1.0,
                            thickness: 0.2,
                            color: Colors.grey,
                          ),
                          SettingsTile(
                            assetName: 'assets/icons/subscription.svg',
                            text: 'Subscription info',
                            action: SvgPicture.asset('assets/icons/arrow.svg'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyScreenForVIew(
                                      url: 'https://google.com/'),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            indent: 16,
                            endIndent: 10,
                            height: 1.0,
                            thickness: 0.2,
                            color: Colors.grey,
                          ),
                          SettingsTile(
                            assetName: 'assets/icons/notification.svg',
                            text: 'Send Notification',
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyScreenForVIew(
                                      url: 'https://google.com/'),
                                ),
                              );
                            },
                            action: IOSStyleToggle(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
