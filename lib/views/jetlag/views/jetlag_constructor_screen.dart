import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:jorney_map/views/app/widgets/input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../data/model/jetlag_model.dart';
import 'jetlag_screen.dart';

class JetlagConstructorScreen extends StatefulWidget {
  @override
  _JetlagConstructorScreenState createState() =>
      _JetlagConstructorScreenState();
}

class _JetlagConstructorScreenState extends State<JetlagConstructorScreen> {
  late SharedPreferences _prefs;
  late TimeOfDay selectedTime = TimeOfDay.now();
  final TextEditingController _homeCountryController = TextEditingController();
  final TextEditingController _destinationCountryController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  void _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  void saveJetlagInfo(
      String homeCountry, String destinationCountry, TimeOfDay time) {
    JetlagModel jetlag = JetlagModel(
        homeCountry: homeCountry,
        destinationCountry: destinationCountry,
        time: time);

    _prefs.setString('homeCountry', jetlag.homeCountry);
    _prefs.setString('destinationCountry', jetlag.destinationCountry);
    _prefs.setString('time', jetlag.time.format(context));
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputWidget(
                  controller: _homeCountryController,
                  labelText: 'Home Country'),
              SizedBox(height: 10),
              InputWidget(
                  controller: _destinationCountryController,
                  labelText: 'Destination Country'),
              SizedBox(height: 10),
              Container(
                width: size.width * 0.95,
                height: size.height * 0.06,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey,
                    width: 0.5,
                  ),
                ),
                child: InkWell(
                  onTap: () => _selectTime(context),
                  child: Row(
                    children: [
                      SizedBox(width: 5),
                      SvgPicture.asset('assets/icons/clock.svg'),
                      SizedBox(width: 10),
                      Text(' ${selectedTime.format(context)}'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ChosenActionButton(
                text: 'Save',
                onTap: () {
                  if (_homeCountryController.text.isEmpty ||
                      _destinationCountryController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all the fields.'),
                      ),
                    );
                  } else {
                    String homeCountry = _homeCountryController.text;
                    String destinationCountry =
                        _destinationCountryController.text;
                    saveJetlagInfo(
                        homeCountry, destinationCountry, selectedTime);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => JetlagScreen()),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _homeCountryController.dispose();
    _destinationCountryController.dispose();
    super.dispose();
  }
}
