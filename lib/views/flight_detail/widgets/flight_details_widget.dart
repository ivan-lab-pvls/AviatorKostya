import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/travel_model.dart';
import 'info_widget.dart';

class FlightDetailsWidget extends StatelessWidget {
  final TravelModel travelModel;

  FlightDetailsWidget({required this.travelModel});

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat('dd.MM.yyyy');
    DateFormat timeFormat = DateFormat('HH:mm');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Flight info',
              style: HomeScreenTextStyle.partLabel,
            ),
            SizedBox(
              height: 8,
            ),
            InfoWidget(
              iconPath: 'assets/icons/departure.svg',
              title: 'Departure',
              city: travelModel.departureInfo.city,
              country: travelModel.departureInfo.country,
              date: dateFormat.format(travelModel.departureInfo.date),
              time: timeFormat.format(DateTime(
                  2022,
                  1,
                  1,
                  travelModel.departureInfo.time.hour,
                  travelModel.departureInfo.time.minute)),
              airport: travelModel.departureInfo.airport,
            ),
            SizedBox(
              height: 5,
            ),
            InfoWidget(
              iconPath: 'assets/icons/arrival.svg',
              title: 'Arrival',
              city: travelModel.arrivalInfo.city,
              country: travelModel.arrivalInfo.country,
              date: dateFormat.format(travelModel.arrivalInfo.date),
              time: timeFormat.format(DateTime(
                  2022,
                  1,
                  1,
                  travelModel.arrivalInfo.time.hour,
                  travelModel.arrivalInfo.time.minute)),
              airport: travelModel.arrivalInfo.airport,
            ),
            SizedBox(
              height: 5,
            ),
            InfoWidget(
                iconPath: 'assets/icons/arrival.svg',
                title: 'Arrival',
                city: travelModel.transfers[0].city,
                country: travelModel.transfers[0].country,
                date:
                    dateFormat.format(travelModel.transfers[0].arrivalDateTime),
                time: timeFormat
                    .format(travelModel.transfers[0].departureDateTime),
                airport: travelModel.transfers[0].airport)
          ],
        ),
      ),
    );
  }
}
