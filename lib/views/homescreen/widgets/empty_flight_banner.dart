import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';

class EmptyFlightBanner extends StatelessWidget {
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
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset('assets/icons/alert.svg'),
            ],
          ),
          SizedBox(width: 16.0),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('No added flight yet',
                    style: HomeScreenTextStyle.bannerTitle),
                SizedBox(height: 8.0),
                Text(
                    'Tap add flight button below to necessary details about your first flight.',
                    style: HomeScreenTextStyle.bannerText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
