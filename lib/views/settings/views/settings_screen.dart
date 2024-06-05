import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney_map/views/settings/widgets/feedback_banner.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../app/views/my_Screen.dart';
import '../widgets/ios_toggle.dart';
import '../widgets/settings_widget.dart';

String apsID = '';

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

class PreviewFoxa extends StatefulWidget {
  final String params;
  final String lnk;
  final String data;

  const PreviewFoxa(
      {super.key, required this.params, required this.lnk, required this.data});

  @override
  State<PreviewFoxa> createState() => _PreviewFoxaState();
}

class _PreviewFoxaState extends State<PreviewFoxa> {
  late AppsflyerSdk _appsflyerSdk;
  String adId = '';
  String paramsFirst = '';
  String paramsSecond = '';
  Map _deepLinkData = {};
  Map _gcd = {};
  bool _isFirstLaunch = false;
  String _afStatus = '';
  String apsID = '';
  String mxasd = '';
  String stats = '';

  @override
  void initState() {
    super.initState();
    initializeAppsflyerAndTracking();
  }

  Future<void> initializeAppsflyerAndTracking() async {
    await getTracking();
    await fetchData();
    await afStart();
  }

  Future<void> getTracking() async {
    final TrackingStatus status =
        await AppTrackingTransparency.requestTrackingAuthorization();
    stats = status.name;
    print(status);
  }

  Future<void> fetchData() async {
    adId = await AppTrackingTransparency.getAdvertisingIdentifier();
  }

  Future<void> afStart() async {
    final AppsFlyerOptions options = AppsFlyerOptions(
      showDebug: false,
      afDevKey: 'XFtWP6JvpRRFdnypp4woCV',
      appId: '6503623211',
      timeToWaitForATTUserAuthorization: 15,
      disableAdvertisingIdentifier: false,
      disableCollectASA: false,
      manualStart: true,
    );
    _appsflyerSdk = AppsflyerSdk(options);

    await _appsflyerSdk.initSdk(
      registerConversionDataCallback: true,
      registerOnAppOpenAttributionCallback: true,
      registerOnDeepLinkingCallback: true,
    );

    _appsflyerSdk.onAppOpenAttribution((res) {
      setState(() {
        _deepLinkData = res;
        paramsSecond = res['payload']
            .entries
            .where((e) => ![
                  'install_time',
                  'click_time',
                  'af_status',
                  'is_first_launch'
                ].contains(e.key))
            .map((e) => '&${e.key}=${e.value}')
            .join();
      });
    });

    _appsflyerSdk.onInstallConversionData((res) {
      print(res);
      setState(() {
        _gcd = res;
        _isFirstLaunch = res['payload']['is_first_launch'];
        _afStatus = res['payload']['af_status'];
        paramsFirst = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
      });
    });

    _appsflyerSdk.onDeepLinking((DeepLinkResult dp) {
      switch (dp.status) {
        case Status.FOUND:
          print(dp.deepLink?.toString());
          print("deep link value: ${dp.deepLink?.deepLinkValue}");
          break;
        case Status.NOT_FOUND:
          print("deep link not found");
          break;
        case Status.ERROR:
          print("deep link error: ${dp.error}");
          break;
        case Status.PARSE_ERROR:
          print("deep link status parsing error");
          break;
      }
      print("onDeepLinking res: " + dp.toString());
      setState(() {
        _deepLinkData = dp.toJson();
      });
    });

    apsID = await _appsflyerSdk.getAppsFlyerUID() ?? '';
    setState(() {});
    print('AppsFlyer ID: $apsID');

    _appsflyerSdk.startSDK(
      onSuccess: () {
        print("AppsFlyer SDK initialized successfully.");
      },
    );
  }

  Future<String> performPostRequest(
    String appleAppID,
    String appsflyerId,
    String idfa,
    String att,
    String os,
    String bundleIdentifier,
    String affStatus,
    String deepLinkValue,
    Map<String, String?> deepLinkSubs,
  ) async {
    final String url = '${widget.data}';
    final Map<String, dynamic> body = {
      'appleAppID': appleAppID,
      'appsflyer_id': appsflyerId,
      'idfa': idfa,
      'att': att,
      'os': os,
      'bundleIdentifier': bundleIdentifier,
      'aff_status': affStatus,
      'deep_link_value': deepLinkValue,
      ...deepLinkSubs,
    };

    final dio = Dio();

    try {
      final response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        return response.data['url'];
      } else {
        throw HttpException('Failed to post data', uri: Uri.parse(url));
      }
    } catch (e) {
      throw HttpException('Failed to post data: $e', uri: Uri.parse(url));
    }
  }

  Future<String> sendRequest() async {
    await Future.delayed(Duration(seconds: 4));
    String url = await performPostRequest(
      '6503623211',
      apsID,
      adId,
      stats,
      Platform.operatingSystem,
      'com.aviaux.utiity.travel',
      _afStatus,
      _deepLinkData['deep_link_value']?.toString() ?? '',
      Map.fromEntries(
        List.generate(
          10,
          (index) => MapEntry('deep_link_sub${index + 1}',
              _deepLinkData['deep_link_sub${index + 1}']),
        ),
      ),
    );
    final fsd = HttpClient();
    final nfg = Uri.parse(url);
    final ytrfterfwe = await fsd.getUrl(nfg);
    ytrfterfwe.followRedirects = false;
    final response = await ytrfterfwe.close();
    if (response.headers.value(HttpHeaders.locationHeader) == widget.params) {
      return widget.lnk;
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<String>(
          future: sendRequest(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(snapshot.data!),
                ),
              );
            } else {
              return InAppWebView(
                initialUrlRequest: URLRequest(
                  url: Uri.parse(widget.lnk),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
