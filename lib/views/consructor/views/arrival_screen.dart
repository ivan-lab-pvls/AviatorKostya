import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:jorney_map/views/consructor/views/transfer_screen.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/arrival_info_model.dart';

import '../../../data/model/travel_model.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/input_widget.dart';

class ArrivalScreen extends StatefulWidget {
  @override
  _ArrivalScreenState createState() => _ArrivalScreenState();
}

class _ArrivalScreenState extends State<ArrivalScreen> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController airportController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Text(
              'New flight',
              style: ConstructorTextStyle.appBar,
            ),
            Text(
              'Arrival',
              style: ConstructorTextStyle.appBarTitle,
            ),
          ],
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/icons/leading.svg'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Arrival at destination',
              style: HomeScreenTextStyle.partLabel,
            ),
            InputWidget(
              controller: countryController,
              labelText: 'Country of arrival',
            ),
            SizedBox(height: 8),
            InputWidget(
              controller: cityController,
              labelText: 'City of arrival',
            ),
            SizedBox(height: 8),
            InputWidget(
              controller: airportController,
              labelText: 'Airport name',
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: size.width * 0.43,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                  ),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: Row(
                      children: [
                        SizedBox(width: 5),
                        SvgPicture.asset('assets/icons/calendar.svg'),
                        SizedBox(width: 10),
                        Text(
                            ' ${DateFormat('dd.MM.yyyy').format(selectedDate)}'),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: size.width * 0.43,
                  height: size.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.blackColor.withOpacity(0.06),
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
              ],
            ),
            SizedBox(height: 8),
            SizedBox(height: 20),
            ChosenActionButton(
              text: 'Next',
              onTap: () async {
                if (countryController.text.isEmpty ||
                    cityController.text.isEmpty ||
                    airportController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.whiteColor,
                      content: Text(
                        'Please fill in all the fields.',
                        style: HomeScreenTextStyle.textButton,
                      ),
                    ),
                  );
                } else {
                  final sharedPrefsService = SharedPrefsService();
                  final travelModelList =
                      await sharedPrefsService.getTravelModelList();

                  if (travelModelList.isNotEmpty) {
                    final lastTravelModel = travelModelList.last;
                    final arrivalInfo = ArrivalInfoModel(
                      country: countryController.text,
                      city: cityController.text,
                      airport: airportController.text,
                      date: selectedDate,
                      time: selectedTime,
                    );

                    final updatedTravelModel = TravelModel(
                      departureInfo: lastTravelModel.departureInfo,
                      arrivalInfo: arrivalInfo,
                      transfers: lastTravelModel.transfers,
                    );

                    travelModelList[travelModelList.length - 1] =
                        updatedTravelModel;
                    await sharedPrefsService
                        .saveTravelModelList(travelModelList);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TransferScreen()),
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.redColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.redColor),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }
}
