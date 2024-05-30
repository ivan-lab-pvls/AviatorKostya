import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';

class EmptyPlansBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                SvgPicture.asset('assets/icons/note.svg'),
              ],
            ),
            SizedBox(width: 16.0),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add plans for free time',
                      style: HomeScreenTextStyle.bannerTitle),
                  SizedBox(height: 8.0),
                  Text(
                      'It seems that the transfer time is very long, add plans for this period.',
                      style: HomeScreenTextStyle.bannerText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
