import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/consts/app_text_styles/onboarding_text_style.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../jetlag/views/jetlag_constructor_screen.dart';
import 'dart:convert';
import 'dart:io';

Future<Map<String, dynamic>> performPostRequest(
  String appleAppID,
  String appsflyerId,
  String? idfa,
  String? att,
  String? os,
  String? bundleIdentifier,
  String? affStatus,
  String? deepLinkValue,
  Map<String, String?> deepLinkSubs,
) async {
  final Uri url = Uri.parse('https://appsnovashop.com/install/deep/6503623211');
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

  final HttpClient client = HttpClient();
  final HttpClientRequest request = await client.postUrl(url);
  request.headers.set(HttpHeaders.contentTypeHeader, 'application/json');
  request.add(utf8.encode(json.encode(body)));

  final HttpClientResponse response = await request.close();
  final String responseBody = await response.transform(utf8.decoder).join();

  if (response.statusCode == 200) {
    return json.decode(responseBody);
  } else {
    throw HttpException('Failed to post data', uri: url);
  }
}

class JetlagBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
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
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/icons/jetlag.svg'),
                ],
              ),
              SizedBox(width: 16.0),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Jetlag helper',
                        style: HomeScreenTextStyle.bannerTitle),
                    SizedBox(height: 8.0),
                    Text(
                        'Will help you to go bed in time for a better adaptation.',
                        style: HomeScreenTextStyle.bannerText),
                  ],
                ),
              ),
            ],
          ),
          ChosenActionButton(
            text: 'Start Jetlag',
            textStyle: OnboardingTextStyle.buttonRed,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => JetlagConstructorScreen()),
              );
            },
            color: AppColors.redColor.withOpacity(0.14),
          )
        ],
      ),
    );
  }
}
