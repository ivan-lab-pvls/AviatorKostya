import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_colors.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';

class InfoWidget extends StatelessWidget {
  final String iconPath;
  final String title;
  final String city;
  final String country;
  final String date;
  final String time;
  final String airport;

  InfoWidget({
    required this.iconPath,
    required this.title,
    required this.city,
    required this.country,
    required this.date,
    required this.time,
    required this.airport,
  });

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
              SvgPicture.asset(
                iconPath,
                color: AppColors.redColor,
              ),
              SizedBox(width: 8.0),
              Text(
                title,
                style: HomeScreenTextStyle.statsSubtitle,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Text(
                '$city, $country',
                style: HomeScreenTextStyle.flightCountry,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Date: ', style: HomeScreenTextStyle.statsTitle),
                  Text(date, style: HomeScreenTextStyle.statsSubtitle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Time: ', style: HomeScreenTextStyle.statsTitle),
                  Text(time, style: HomeScreenTextStyle.statsSubtitle),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Airport: ', style: HomeScreenTextStyle.statsTitle),
                  Text(airport, style: HomeScreenTextStyle.statsSubtitle),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
