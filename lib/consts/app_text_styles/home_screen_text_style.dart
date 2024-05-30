import 'package:flutter/material.dart';

import '../app_colors.dart';

class HomeScreenTextStyle {
  static const TextStyle title = TextStyle(
    fontFamily: 'Inter',
    fontSize: 20.0,
    fontWeight: FontWeight.w700,
    color: AppColors.blackColor,
  );
  static const TextStyle settings = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );
  static TextStyle partLabel = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static TextStyle textButton = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.redColor,
  );
  static const TextStyle bannerTitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );
  static TextStyle bannerText = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static TextStyle statsTitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor.withOpacity(0.4),
  );
  static TextStyle statsSubtitle = TextStyle(
    fontFamily: 'Inter',
    fontSize: 16.0,
    fontWeight: FontWeight.w500,
    color: AppColors.blackColor,
  );

  static const TextStyle flightCountry = TextStyle(
      fontFamily: 'Inter',
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
      color: AppColors.blackColor);
  static TextStyle flightCity = TextStyle(
      fontFamily: 'Inter',
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor.withOpacity(0.4));
  static TextStyle flightDate = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor);

  static const TextStyle plansLabel = TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor);

  static TextStyle plansText = TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor.withOpacity(0.4));

  static TextStyle jetlagCountry = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: AppColors.whiteColor);
  static TextStyle jetlagTime = const TextStyle(
      fontFamily: 'Inter',
      fontSize: 26.0,
      fontWeight: FontWeight.w500,
      color: AppColors.blackColor);
}
