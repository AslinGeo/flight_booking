import 'package:flight_booking/view/flight_list/view.dart';
import 'package:flight_booking/view/home/view.dart';
import 'package:flight_booking/view/splash/view.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/flightList',
      builder: (context, state) => FlightListView(
        searchedFlightDetails: state.extra as Map<String, dynamic>,
      ),
    ),
  ],
);
