import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';

class JetlagInfoWidget extends StatelessWidget {
  final String homeCountry;
  final String destinationCountry;
  final String time;

  JetlagInfoWidget({
    required this.homeCountry,
    required this.destinationCountry,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'You have to go to bed at',
            style: HomeScreenTextStyle.bannerText,
          ),
          SizedBox(height: 8.0),
          Text(
            '$time',
            style: HomeScreenTextStyle.jetlagTime,
          ),
          SizedBox(height: 8.0),
          Container(
            width: size.width * 0.45,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              color: AppColors.redColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    homeCountry,
                    style:
                        TextStyle(fontSize: 16.0, color: AppColors.whiteColor),
                  ),
                  SizedBox(width: 5.0),
                  SvgPicture.asset('assets/icons/departure.svg'),
                  SizedBox(width: 5.0),
                  Text(
                    destinationCountry,
                    style:
                        TextStyle(fontSize: 16.0, color: AppColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
