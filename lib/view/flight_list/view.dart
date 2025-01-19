import 'dart:math';

import 'package:flight_booking/common/flight_card.dart';
import 'package:flight_booking/constants/assets.dart';
import 'package:flight_booking/constants/colors.dart';
import 'package:flight_booking/constants/strings.dart';
import 'package:flight_booking/constants/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../common/appbar.dart';
import '../../view_model/flight_list/view_model.dart';

class FlightListView extends StatefulWidget {
  final Map<String, dynamic> searchedFlightDetails;
  const FlightListView({super.key, required this.searchedFlightDetails});

  @override
  State<FlightListView> createState() => _FlightListViewState();
}

class _FlightListViewState extends State<FlightListView> {
  ViewModel viewModel = ViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.setFlightDetails(widget.searchedFlightDetails);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ViewModel>(
      create: (context) => viewModel,
      child: Consumer<ViewModel>(builder: (context, child, model) {
        return Scaffold(
          appBar: myAppBar(),
          body: body(),
        );
      }),
    );
  }

  myAppBar() {
    return const PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: MyAppBar(title: AppStrings.ezyTravel));
  }

  Widget body() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        _flightInfoCard(context),
        const SizedBox(
          height: 20,
        ),
        _dayFilterWidget(context),
        const SizedBox(
          height: 20,
        ),
        _flightListView()
      ],
    );
  }

  Widget _flightInfoCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${viewModel.searchedFlightDetails['fromDestination']}  to ${viewModel.searchedFlightDetails['toDestination']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                '${AppStrings.departure}: ${viewModel.searchedFlightDetails['departureDate'] != null ? viewModel.formatDate(viewModel.searchedFlightDetails['departureDate']) : 'Sat, 23 Mar'} - ${AppStrings.returnText}: ${viewModel.searchedFlightDetails['returnDate'] != null ? viewModel.formatDate(viewModel.searchedFlightDetails['returnDate']) : 'Sat, 30 Mar'}',
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 5),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '(${AppStrings.roundTrip})',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(width: 10),
                  Text(
                    AppStrings.modifySearch,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              const Divider(),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        AppStrings.sort,
                        style: AppTypography.captionBold14,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down_outlined)
                    ],
                  ),
                  Text(
                    AppStrings.nonStop,
                    style: AppTypography.captionBold14,
                  ),
                  Row(
                    children: [
                      Text(
                        AppStrings.filter,
                        style: AppTypography.captionBold14,
                      ),
                      const SizedBox(width: 10),
                      SvgPicture.asset(AppAssets.filterSvg)
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dayFilterWidget(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _dayWidget(
            addDate(viewModel.searchedFlightDetails['departureDate'], -1),
            viewModel
                .formatDate(viewModel.searchedFlightDetails['departureDate'])),
        _dayWidget(
            viewModel
                .formatDate(viewModel.searchedFlightDetails['departureDate']),
            addDate(viewModel.searchedFlightDetails['departureDate'], 1)),
        _dayWidget(
            viewModel
                .formatDate(viewModel.searchedFlightDetails['departureDate']),
            addDate(viewModel.searchedFlightDetails['departureDate'], 2)),
      ],
    );
  }

  addDate(date, addDay) {
    DateTime dateV = DateTime.parse(date).add(Duration(days: addDay));
    String formattedDate = DateFormat('MMM d').format(dateV);
    return formattedDate;
  }

  _dayWidget(firstDate, secondDate) {
    Random random = Random();
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            '$firstDate - $secondDate',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          Text(
            '${AppStrings.fromAed} ${random.nextInt(1000)}',
            style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _flightListView() {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: 3,
          itemBuilder: (context, index) {
            return FlightBookingCard(
              fromDestination:
                  viewModel.searchedFlightDetails['fromDestination'],
              toDestination: viewModel.searchedFlightDetails['toDestination'],
            );
          }),
    );
  }
}
