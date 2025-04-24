import 'package:flutter/material.dart';

import '../constraints/app_text_style.dart';

class AppRadioButton extends StatefulWidget {
  final String title;
  final ValueChanged<int> onChanged;
  final int selectedValue;

  const AppRadioButton({
    super.key,
    required this.title,
    required this.onChanged,
    required this.selectedValue,
  });

  @override
  _AppRadioButtonState createState() => _AppRadioButtonState();
}

class _AppRadioButtonState extends State<AppRadioButton> {
  int selectedValue = 1; // Default value

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Radio<int>(
          value: 1,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
            });
            widget.onChanged(value!);
          },
        ),
        Text(
          widget.title,
          style: text14Style(
            isWeight400: true,
            isRoboto: true,
          ),
        ),
      ],
    );
  }
}
