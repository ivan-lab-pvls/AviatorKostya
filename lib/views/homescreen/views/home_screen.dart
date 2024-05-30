import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:jorney_map/views/homescreen/widgets/empty_flight_banner.dart';
import 'package:jorney_map/views/homescreen/widgets/jetlag_banner.dart';
import 'package:jorney_map/views/statistics/views/stats_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/model/travel_model.dart';
import '../../../util/app_routes.dart';
import '../../../util/shared_pref_service.dart';
import '../../consructor/views/departure_screen.dart';
import '../widgets/jetlag_info_widget.dart';
import '../widgets/stats_info_widget.dart';
import '../widgets/travel_info_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TravelModel> travelList = [];
  final SharedPrefsService _sharedPrefsService = SharedPrefsService();
  String? _homeCountry;
  String? _destinationCountry;
  String? _time;

  @override
  void initState() {
    super.initState();
    _loadTravelListFromSharedPref();
    _loadJetlagInfo();
  }

  Future<void> _loadJetlagInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _homeCountry = prefs.getString('homeCountry');
      _destinationCountry = prefs.getString('destinationCountry');
      _time = prefs.getString('time');
    });
  }

  Future<void> _loadTravelListFromSharedPref() async {
    travelList = await _sharedPrefsService.getTravelModelList();
    setState(() {});
  }

  Future<void> _saveTravelListToSharedPref() async {
    await _sharedPrefsService.saveTravelModelList(travelList);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int _currentPage = 0;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Text(
          'Flights',
          style: HomeScreenTextStyle.title,
        ),
        centerTitle: false,
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
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Your flight', style: HomeScreenTextStyle.partLabel),
                travelList.isEmpty
                    ? EmptyFlightBanner()
                    : SizedBox(
                        height: size.height * 0.375,
                        child: Stack(
                          children: [
                            PageView.builder(
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentPage = page;
                                });
                              },
                              itemCount: travelList.length,
                              itemBuilder: (context, index) {
                                return TravelInfoWidget(
                                  travelModel: travelList[index],
                                );
                              },
                            ),
                            Positioned(
                              bottom: 15,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  travelList.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: index == _currentPage
                                            ? AppColors.redColor
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                ChosenActionButton(
                  text: 'Add new flight',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DepartureScreen()),
                    ).then((newTravelModel) {
                      if (newTravelModel != null) {
                        setState(() {
                          travelList.add(newTravelModel);
                          _saveTravelListToSharedPref();
                        });
                      }
                    });
                  },
                ),
                Text('Jetlag', style: HomeScreenTextStyle.partLabel),
                SizedBox(
                  height: 8,
                ),
                _homeCountry != null &&
                        _destinationCountry != null &&
                        _time != null
                    ? JetlagInfoWidget(
                        homeCountry: _homeCountry!,
                        destinationCountry: _destinationCountry!,
                        time: _time!,
                      )
                    : JetlagBanner(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Text(
                      'Flight statistics',
                      style: HomeScreenTextStyle.partLabel,
                    ),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StatsScreen()),
                          );
                        },
                        child: Text(
                          'See stats',
                          style: HomeScreenTextStyle.textButton,
                        ))
                  ],
                ),
                StatsWidget(travelList: travelList),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
