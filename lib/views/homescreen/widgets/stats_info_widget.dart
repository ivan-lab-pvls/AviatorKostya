import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';

import '../../../data/model/travel_model.dart';

class StatsWidget extends StatelessWidget {
  final List<TravelModel> travelList;

  StatsWidget({required this.travelList});

  @override
  Widget build(BuildContext context) {
    if (travelList.isEmpty) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/visited.svg'),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Visited',
                        style: HomeScreenTextStyle.statsTitle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '0',
                        style: HomeScreenTextStyle.statsSubtitle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/spend_in_flight.svg'),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Total in Flights',
                      style: HomeScreenTextStyle.statsTitle,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text('0 hours ', style: HomeScreenTextStyle.statsSubtitle),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: EdgeInsets.all(8),
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
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/jetlag.svg'),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Longest Flight',
                        style: HomeScreenTextStyle.statsTitle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text('none', style: HomeScreenTextStyle.statsSubtitle),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    int visitedCountries =
        travelList.map((travel) => travel?.arrivalInfo.country).toSet().length;

    Duration totalTimeInFlights =
        travelList.fold(Duration.zero, (prev, travel) {
      DateTime departureDateTime = DateTime(
        travel.departureInfo.date.year,
        travel.departureInfo.date.month,
        travel.departureInfo.date.day,
        travel.departureInfo.time.hour,
        travel.departureInfo.time.minute,
      );
      DateTime arrivalDateTime = DateTime(
        travel.arrivalInfo.date.year,
        travel.arrivalInfo.date.month,
        travel.arrivalInfo.date.day,
        travel.arrivalInfo.time.hour,
        travel.arrivalInfo.time.minute,
      );
      return prev + arrivalDateTime.difference(departureDateTime);
    });

    TravelModel longestFlight = travelList.reduce((curr, next) {
      DateTime departureDateTimeCurr = DateTime(
        curr.departureInfo.date.year,
        curr.departureInfo.date.month,
        curr.departureInfo.date.day,
        curr.departureInfo.time.hour,
        curr.departureInfo.time.minute,
      );
      DateTime arrivalDateTimeCurr = DateTime(
        curr.arrivalInfo.date.year,
        curr.arrivalInfo.date.month,
        curr.arrivalInfo.date.day,
        curr.arrivalInfo.time.hour,
        curr.arrivalInfo.time.minute,
      );

      DateTime departureDateTimeNext = DateTime(
        next.departureInfo.date.year,
        next.departureInfo.date.month,
        next.departureInfo.date.day,
        next.departureInfo.time.hour,
        next.departureInfo.time.minute,
      );
      DateTime arrivalDateTimeNext = DateTime(
        next.arrivalInfo.date.year,
        next.arrivalInfo.date.month,
        next.arrivalInfo.date.day,
        next.arrivalInfo.time.hour,
        next.arrivalInfo.time.minute,
      );

      return arrivalDateTimeCurr.difference(departureDateTimeCurr) >
              arrivalDateTimeNext.difference(departureDateTimeNext)
          ? curr
          : next;
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(4),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/visited.svg'),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Visited Countries',
                      style: HomeScreenTextStyle.statsTitle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(visitedCountries.toString(),
                        style: HomeScreenTextStyle.statsSubtitle),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.all(4),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/spend_in_flight.svg'),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Total Time in Flights',
                      style: HomeScreenTextStyle.statsTitle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                        '${totalTimeInFlights.inHours}h ${totalTimeInFlights.inMinutes.remainder(60)}m',
                        style: HomeScreenTextStyle.statsSubtitle),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.all(4),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/jetlag.svg'),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Longest Flight',
                      style: HomeScreenTextStyle.statsTitle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                        '${longestFlight.departureInfo.city} to ${longestFlight.arrivalInfo.city}',
                        style: HomeScreenTextStyle.statsSubtitle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
