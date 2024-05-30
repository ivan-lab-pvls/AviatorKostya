import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../consts/app_colors.dart';
import '../../../consts/app_text_styles/constructor_text_style.dart';

class InputWidget extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? labelText;
  final String? iconPath;

  const InputWidget({
    Key? key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.labelText,
    this.iconPath,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  late FocusNode _focusNode;
  late ValueNotifier<bool> _hasText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _hasText = ValueNotifier<bool>(widget.controller.text.isNotEmpty);

    _focusNode.addListener(_onFocusChange);
    widget.controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    widget.controller.removeListener(_onTextChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  void _onTextChange() {
    _hasText.value = widget.controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: AppColors.blackColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border(
            right: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            left: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            top: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
              labelText: widget.labelText,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              border: InputBorder.none,
              labelStyle: ConstructorTextStyle.subtitle),
          keyboardType: widget.keyboardType,
        ),
      ),
    );
  }
}
