import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';

import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/travel_model.dart';
import '../../../util/shared_pref_service.dart';

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  List<TravelModel> travelList = [];
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();

  @override
  void initState() {
    super.initState();
    _loadTravelListFromSharedPref();
  }

  Future<void> _loadTravelListFromSharedPref() async {
    travelList = await _sharedPrefsService.getTravelModelList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<String> visitedCountries = travelList.isNotEmpty
        ? travelList
            .map((travel) => travel.arrivalInfo.country)
            .toSet()
            .toList()
        : [];

    Duration totalTimeInFlights = travelList.isNotEmpty
        ? travelList.fold(Duration.zero, (prev, travel) {
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
          })
        : Duration.zero;

    TravelModel? longestFlight = travelList.isNotEmpty
        ? travelList.reduce((curr, next) {
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
          })
        : null;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Flights statistics',
          style: ConstructorTextStyle.appBar,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.2),
          child: Container(
            height: 0.2,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
      ),
      body: travelList.isEmpty
          ? Center(
              child: Text(
              'No travel data available',
              style: HomeScreenTextStyle.partLabel,
            ))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Visited Countries:',
                          style: HomeScreenTextStyle.partLabel,
                        ),
                        Column(
                          children: visitedCountries
                              .map((country) => Container(
                                    height: size.height * 0.06,
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
                                    margin: const EdgeInsets.only(bottom: 8.0),
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/icons/planet.svg'),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          country,
                                          style:
                                              HomeScreenTextStyle.flightCountry,
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Spend in flights',
                    style: HomeScreenTextStyle.partLabel,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: size.height * 0.06,
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
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/clock.svg'),
                            Spacer(),
                            Text(
                              '${totalTimeInFlights.inHours} hours ${totalTimeInFlights.inMinutes.remainder(60)} minutes',
                              style: HomeScreenTextStyle.partLabel,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Text(
                    'The largest flight took',
                    style: HomeScreenTextStyle.partLabel,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: longestFlight != null
                        ? Container(
                            height: size.height * 0.06,
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
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Center(
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/icons/jetlag.svg'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      '${longestFlight.departureInfo.city}-${longestFlight.arrivalInfo.city}',
                                      style: HomeScreenTextStyle.flightCountry,
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                      '${longestFlight.arrivalInfo.date.difference(longestFlight.departureInfo.date).inHours} hours',
                                      style: HomeScreenTextStyle.partLabel),
                                ],
                              ),
                            ),
                          )
                        : Text('No longest flight data available'),
                  ),
                ],
              ),
            ),
    );
  }
}
