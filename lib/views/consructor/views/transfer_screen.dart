import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:jorney_map/views/homescreen/views/home_screen.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';
import '../../../consts/app_text_styles/home_screen_text_style.dart';
import '../../../data/model/transfer_model.dart';
import '../../../data/model/travel_model.dart';
import '../../../util/shared_pref_service.dart';
import '../../app/widgets/input_widget.dart';

class TransferScreen extends StatefulWidget {
  @override
  _TransferScreenState createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  List<TransferModel> transfers = [];

  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController airportController = TextEditingController();

  DateTime selectedDepartureDateTime = DateTime.now();
  DateTime selectedArrivalDateTime = DateTime.now();

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
              'Transfer',
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
              'Add Transfer Info',
              style: HomeScreenTextStyle.partLabel,
            ),
            InputWidget(
              controller: countryController,
              labelText: 'Country',
            ),
            SizedBox(height: 8),
            InputWidget(
              controller: cityController,
              labelText: 'City',
            ),
            SizedBox(height: 8),
            InputWidget(
              controller: airportController,
              labelText: 'Airport',
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      'Departure',
                      style: HomeScreenTextStyle.partLabel,
                    ),
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
                        onTap: () => _selectDepartureDateTime(context),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            SvgPicture.asset('assets/icons/calendar.svg'),
                            SizedBox(width: 10),
                            Text(
                                '${DateFormat('yyyy-MM-dd').format(selectedDepartureDateTime)}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      'Arrival',
                      style: HomeScreenTextStyle.partLabel,
                    ),
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
                        onTap: () => _selectArrivalDateTime(context),
                        child: Row(
                          children: [
                            SizedBox(width: 5),
                            SvgPicture.asset('assets/icons/calendar.svg'),
                            SizedBox(width: 10),
                            Text(
                                '${DateFormat('yyyy-MM-dd').format(selectedArrivalDateTime)}'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ChosenActionButton(
              text: 'Done',
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
                    final transfer = TransferModel(
                      country: countryController.text,
                      city: cityController.text,
                      airport: airportController.text,
                      departureDateTime: selectedDepartureDateTime,
                      arrivalDateTime: selectedArrivalDateTime,
                    );

                    final updatedTransfers = [
                      ...lastTravelModel.transfers,
                      transfer
                    ];

                    final updatedTravelModel = TravelModel(
                      departureInfo: lastTravelModel.departureInfo,
                      arrivalInfo: lastTravelModel.arrivalInfo,
                      transfers: updatedTransfers,
                    );

                    travelModelList[travelModelList.length - 1] =
                        updatedTravelModel;
                    await sharedPrefsService
                        .saveTravelModelList(travelModelList);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  }
                }
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDepartureDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDepartureDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.redColor),
            dialogBackgroundColor: AppColors.blackColor.withOpacity(0.06),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDepartureDateTime),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.redColor),
              dialogBackgroundColor: AppColors.blackColor.withOpacity(0.06),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedDepartureDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _selectArrivalDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedArrivalDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(primary: AppColors.redColor),
            dialogBackgroundColor: AppColors.blackColor.withOpacity(0.06),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedArrivalDateTime),
        builder: (context, child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(primary: AppColors.redColor),
              dialogBackgroundColor: AppColors.blackColor.withOpacity(0.06),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null) {
        setState(() {
          selectedArrivalDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
}
