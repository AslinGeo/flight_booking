import 'package:flight_booking/common/appbar.dart';
import 'package:flight_booking/common/travel_card.dart';
import 'package:flight_booking/constants/assets.dart';
import 'package:flight_booking/constants/colors.dart';
import 'package:flight_booking/constants/strings.dart';
import 'package:flight_booking/constants/typography.dart';
import 'package:flight_booking/routes/routes.dart';
import 'package:flight_booking/view_model/home/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ViewModel viewModel = ViewModel();
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
        child: MyAppBar(title: AppStrings.searchFlights));
  }

  Widget body() {
    return ListView(
      children: [
        _headerWidget(),
        const SizedBox(
          height: 30,
        ),
        _destinationWidget(context),
        const SizedBox(
          height: 40,
        ),
        _dateWidget(context),
        const SizedBox(
          height: 20,
        ),
        _dropDownWidget(context),
        const SizedBox(
          height: 20,
        ),
        _searchFlightButton(),
        const SizedBox(
          height: 20,
        ),
        _travelTitleWidget(),
        const SizedBox(
          height: 20,
        ),
        _travelList(),
        const SizedBox(
          height: 20,
        ),
        _hotelList(),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Widget _headerWidget() {
    return Stack(children: [
      Container(
        height: 150,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.homeBanner),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(AppStrings.startTrip, style: AppTypography.bodyBold19),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 130),
        child: _customButtons(),
      )
    ]);
  }

  Widget _dateWidget(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.43,
            child: TextFormField(
              decoration: const InputDecoration(
                focusColor: AppColors.green,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green)),
                labelText: AppStrings.departure,
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  viewModel.departureDateController.text = formattedDate;
                }
              },
              controller: viewModel.departureDateController,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.43,
            child: TextFormField(
              decoration: const InputDecoration(
                focusColor: AppColors.green,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green)),
                labelText: AppStrings.returnText,
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (pickedDate != null) {
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  viewModel.returnDateController.text = formattedDate;
                }
              },
              controller: viewModel.returnDateController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropDownWidget(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.43,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                focusColor: AppColors.green,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green)),
                labelText: AppStrings.travelers,
                border: OutlineInputBorder(),
              ),
              value: '1 Passenger',
              items: viewModel.passengerList
                  .map((element) =>
                      DropdownMenuItem(value: element, child: Text(element)))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.43,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                focusColor: AppColors.green,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.green)),
                labelText: AppStrings.cabinClass,
                border: OutlineInputBorder(),
              ),
              value: 'Economy Class',
              items: viewModel.classList
                  .map((element) =>
                      DropdownMenuItem(value: element, child: Text(element)))
                  .toList(),
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _customButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        height: 45,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ], color: AppColors.white, borderRadius: BorderRadius.circular(6)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildCustomButton(AppStrings.roundTrip, 0),
            _buildCustomButton(AppStrings.onWay, 1),
            _buildCustomButton(AppStrings.multiCity, 2),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomButton(String text, int index) {
    bool isSelected = viewModel.isSelected[index]; // Check if selected

    return InkWell(
      onTap: () {
        viewModel.onSelectToggle(index);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: isSelected ? AppColors.green : AppColors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Text(
            text,
            style: AppTypography.captionBold14.copyWith(
                color: isSelected ? AppColors.white : AppColors.darkGray),
          ),
        ),
      ),
    );
  }

  Widget _destinationWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 4),
                blurRadius: 1,
                spreadRadius: 1,
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () async {
                      String? value = await bottomSheet(context);
                      if (value != null) {
                        viewModel.fromDestination = value;
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AppAssets.flightSvg),
                          const SizedBox(width: 20),
                          Text(
                            viewModel.fromDestination.isNotEmpty
                                ? viewModel.fromDestination
                                : 'From',
                            style: AppTypography.bodyRegular16,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: const Divider(
                      color: Colors.green,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String? value = await bottomSheet(context);
                      if (value != null) {
                        viewModel.toDestination = value;
                        setState(() {});
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AppAssets.locationSvg),
                          const SizedBox(width: 20),
                          Text(
                            viewModel.toDestination.isNotEmpty
                                ? viewModel.toDestination
                                : 'To',
                            style: AppTypography.bodyRegular16,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                  onTap: () {
                    viewModel.swapDestinations();
                  },
                  child: SvgPicture.asset(AppAssets.undoSvg)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchFlightButton() {
    return Center(
      child: InkWell(
          onTap: () async {
            viewModel.navigateToSearchList(context);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(13)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Text(
                AppStrings.searchFlights,
                style: TextStyle(color: AppColors.white),
              ),
            ),
          )),
    );
  }

  Widget _travelTitleWidget() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(AppStrings.travelInspirations,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _travelList() {
    return SizedBox(
      height: 305,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 20),
          scrollDirection: Axis.horizontal,
          itemCount: viewModel.tours.length,
          itemBuilder: (context, index) {
            return TravelCard(
                imageUrl: viewModel.tours[index]["imageUrl"],
                width: 250,
                height: 300,
                destination: viewModel.tours[index]["destination"],
                description: viewModel.tours[index]["description"]);
          }),
    );
  }

  Widget _hotelList() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.hotelTitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 20,
          ),
          TravelCard(
              imageUrl: AppAssets.tour3,
              width: double.infinity,
              height: 250,
              destination: '',
              description: '')
        ],
      ),
    );
  }

  bottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.006,
                  width: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                    color:
                        const Color.fromARGB(255, 0, 233, 12).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Text('Back'),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 214, 243, 215),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Column(
                        children: [
                          ...viewModel.destinationList.map((data) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(
                                    context, data); // Return selected item
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 30,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      data,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
