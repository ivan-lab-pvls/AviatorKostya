import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/consts/app_text_styles/onboarding_text_style.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../jetlag/views/jetlag_constructor_screen.dart';

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
