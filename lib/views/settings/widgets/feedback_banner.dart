import 'package:flutter/material.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';

class FeedbackBanner extends StatelessWidget {
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
                  Text(
                    'Give us your feedback',
                    style: HomeScreenTextStyle.bannerTitle,
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Help us improve the app with\nyour opinion.',
                    style: HomeScreenTextStyle.bannerText,
                  ),
                ],
              ),
              Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Image.asset(
                    'assets/images/feedback.png',
                    fit: BoxFit.contain,
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
