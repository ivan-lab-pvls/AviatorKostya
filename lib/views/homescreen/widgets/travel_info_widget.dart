import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';
import 'package:jorney_map/consts/app_text_styles/onboarding_text_style.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';

import '../../../data/model/travel_model.dart';
import '../../flight_detail/views/flight_details_screen.dart';

class TravelInfoWidget extends StatelessWidget {
  final TravelModel travelModel;

  TravelInfoWidget({required this.travelModel});
  String _formatDate(DateTime date) {
    final formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.006),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width * 0.01,
                ),
                Column(
                  children: [
                    Text(
                      travelModel.departureInfo.country,
                      style: HomeScreenTextStyle.flightCountry,
                    ),
                    Text(
                      travelModel.departureInfo.city,
                      style: HomeScreenTextStyle.flightCity,
                    )
                  ],
                ),
                Spacer(),
                Image.asset('assets/images/flight.png'),
                Spacer(),
                Column(
                  children: [
                    Text(
                      travelModel.arrivalInfo.country,
                      style: HomeScreenTextStyle.flightCountry,
                    ),
                    Text(
                      travelModel.arrivalInfo.city,
                      style: HomeScreenTextStyle.flightCity,
                    )
                  ],
                ),
                SizedBox(
                  width: size.width * 0.01,
                ),
              ],
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * 0.01,
              ),
              Image.asset('assets/images/dots.png'),
              SizedBox(
                width: size.width * 0.025,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset('assets/images/departure.svg'),
                  SizedBox(
                    height: size.width * 0.01,
                  ),
                  SvgPicture.asset('assets/images/arrival.svg'),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    _formatDate(travelModel.departureInfo.date),
                    style: HomeScreenTextStyle.flightDate,
                  ),
                  SizedBox(
                    height: size.width * 0.015,
                  ),
                  Text(
                    _formatDate(travelModel.departureInfo.date),
                    style: HomeScreenTextStyle.flightDate,
                  ),
                ],
              ),
              SizedBox(
                width: size.width * 0.025,
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/icons/book.svg'),
                Text(
                  'Plans',
                  style: HomeScreenTextStyle.plansLabel,
                ),
                Spacer(),
                Text('2 plans', style: HomeScreenTextStyle.plansText),
                SvgPicture.asset('assets/icons/arrow.svg'),
              ],
            ),
          ),
          ChosenActionButton(
            text: 'See flight details',
            color: AppColors.redColor.withOpacity(0.14),
            textStyle: OnboardingTextStyle.buttonRed,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FlightDetailsScreen(travelModel: travelModel),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
