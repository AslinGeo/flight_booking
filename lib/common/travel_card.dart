import 'package:flight_booking/constants/colors.dart';
import 'package:flutter/widgets.dart';

class TravelCard extends StatelessWidget {
  final String imageUrl;
  final String destination;
  final String description;
  final double width;
  final double height;

  const TravelCard(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      required this.destination,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                description != "" ? "Economy round trip" : "",
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(destination,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
