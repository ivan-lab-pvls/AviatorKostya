import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../homescreen/views/home_screen.dart';

class JetlagScreen extends StatefulWidget {
  @override
  _JetlagScreenState createState() => _JetlagScreenState();
}

class _JetlagScreenState extends State<JetlagScreen> {
  String? _homeCountry;
  String? _destinationCountry;
  String? _time;

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Jetlag',
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Time to go to bed: ',
                        style: HomeScreenTextStyle.partLabel),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/clock.svg',
                          width: 28,
                        ),
                        SizedBox(width: 4.0),
                        Text(' ${_time ?? 'N/A'}',
                            style: HomeScreenTextStyle.jetlagTime),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country of departure',
                                style: HomeScreenTextStyle.bannerText),
                            SizedBox(height: 4.0),
                            Text(_homeCountry ?? 'N/A',
                                style: HomeScreenTextStyle.flightCountry),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Country of arrival',
                                style: HomeScreenTextStyle.bannerText),
                            SizedBox(height: 4.0),
                            Text(_destinationCountry ?? 'N/A',
                                style: HomeScreenTextStyle.flightCountry),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 8.0),
                  ],
                ),
              ),
              SizedBox(height: 4.0),
              ChosenActionButton(
                  text: 'Done',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
