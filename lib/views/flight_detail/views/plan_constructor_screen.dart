import 'package:flutter/material.dart';
import 'package:jorney_map/consts/app_colors.dart';
import 'package:jorney_map/consts/app_text_styles/home_screen_text_style.dart';
import 'package:jorney_map/views/app/widgets/chosen_action_button_widget.dart';
import 'package:jorney_map/views/app/widgets/input_widget.dart';

class PlanConstructorScreen extends StatefulWidget {
  final Function(String, String) onPlanCreated;

  PlanConstructorScreen({required this.onPlanCreated});

  @override
  _PlanConstructorScreenState createState() => _PlanConstructorScreenState();
}

class _PlanConstructorScreenState extends State<PlanConstructorScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _createPlan() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
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
      widget.onPlanCreated(title, description);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create a Plan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputWidget(
              controller: _titleController,
              labelText: 'Title',
            ),
            SizedBox(height: 16.0),
            InputWidget(
              controller: _descriptionController,
              labelText: 'Description',
            ),
            SizedBox(height: 16.0),
            ChosenActionButton(text: 'Create plan', onTap: _createPlan),
          ],
        ),
      ),
    );
  }
}
