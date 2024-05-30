import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';
import 'package:jorney_map/views/flight_detail/views/plan_constructor_screen.dart';
import 'package:jorney_map/views/flight_detail/widgets/empty_plans_banner.dart';
import 'package:jorney_map/views/flight_detail/widgets/plan_widget.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/plan_model.dart';
import '../../../data/model/travel_model.dart';
import '../widgets/flight_details_widget.dart';

class FlightDetailsScreen extends StatefulWidget {
  final TravelModel travelModel;

  FlightDetailsScreen({required this.travelModel});

  @override
  State<FlightDetailsScreen> createState() => _FlightDetailsScreenState();
}

class _FlightDetailsScreenState extends State<FlightDetailsScreen> {
  bool _showFlightDetails = true;
  List<PlanModel>? _plans;

  @override
  void initState() {
    super.initState();
    _plans = widget.travelModel.plans;
  }

  void _addPlan() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanConstructorScreen(
          onPlanCreated: (title, description) {
            setState(() {
              _plans ??= [];
              _plans!.add(PlanModel(title: title, description: description));
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Your flight',
          style: ConstructorTextStyle.appBar,
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      widget.travelModel.departureInfo.country,
                      style: HomeScreenTextStyle.flightCountry,
                    ),
                    Text(
                      widget.travelModel.departureInfo.city,
                      style: HomeScreenTextStyle.flightCity,
                    )
                  ],
                ),
                Spacer(),
                SvgPicture.asset('assets/icons/plain.svg'),
                Spacer(),
                Column(
                  children: [
                    Text(
                      widget.travelModel.arrivalInfo.country,
                      style: HomeScreenTextStyle.flightCountry,
                    ),
                    Text(
                      widget.travelModel.arrivalInfo.city,
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showFlightDetails = true;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: _showFlightDetails ? Colors.red : Colors.grey,
                          width: _showFlightDetails ? 1 : 0.2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _showFlightDetails
                            ? SvgPicture.asset('assets/icons/flight_red.svg')
                            : SvgPicture.asset('assets/icons/flight.svg'),
                        Text(
                          'Flight',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: _showFlightDetails
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showFlightDetails = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(
                          color: !_showFlightDetails
                              ? Colors.red
                              : Colors.transparent,
                          width: !_showFlightDetails ? 1 : 0.2,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        !_showFlightDetails
                            ? SvgPicture.asset('assets/icons/plans_red.svg')
                            : SvgPicture.asset('assets/icons/plans.svg'),
                        Text(
                          'Plans',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: !_showFlightDetails
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.0),
                    if (_showFlightDetails)
                      FlightDetailsWidget(travelModel: widget.travelModel),
                    if (!_showFlightDetails)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Your plans',
                                  style: HomeScreenTextStyle.partLabel,
                                ),
                                Spacer(),
                                TextButton(
                                  onPressed: _addPlan,
                                  child: Text('Add a plan',
                                      style: HomeScreenTextStyle.textButton),
                                ),
                              ],
                            ),
                            if (_plans == null || _plans!.isEmpty)
                              EmptyPlansBanner()
                            else
                              Container(
                                height: size.height * 0.6,
                                child: ListView.builder(
                                  itemCount: _plans!.length,
                                  itemBuilder: (context, index) {
                                    final plan = _plans![index];
                                    return PlanWidget(planModel: plan);
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
