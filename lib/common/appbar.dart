import 'package:flight_booking/constants/colors.dart';
import 'package:flight_booking/constants/strings.dart';
import 'package:flight_booking/constants/typography.dart';
import 'package:flight_booking/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyAppBar extends StatefulWidget {
  final String title;
  const MyAppBar({super.key, required this.title});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.lightOliveGreen,
      leading: IconButton(
          onPressed: () {
            if (widget.title != AppStrings.searchFlights) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back)),
      title: Text(
        widget.title,
        style: AppTypography.medium18,
      ),
    );
  }
}
