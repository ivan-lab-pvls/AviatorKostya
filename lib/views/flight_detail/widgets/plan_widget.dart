import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/data/model/plan_model.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';

class PlanWidget extends StatelessWidget {
  final PlanModel planModel;

  const PlanWidget({required this.planModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/icons/note.svg'),
              SizedBox(
                width: 8,
              ),
              Text(planModel.title, style: HomeScreenTextStyle.bannerTitle)
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: size.width * 0.95,
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
            child: Text(planModel.description,
                style: HomeScreenTextStyle.bannerText),
          )
        ],
      ),
    );
  }
}
