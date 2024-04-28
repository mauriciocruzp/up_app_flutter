import 'package:flutter/material.dart';
import 'package:up_app_flutter/components/nav_bar.dart';
import 'package:up_app_flutter/models/nav_model.dart';
import 'package:up_app_flutter/pages/home_page.dart';
import 'package:up_app_flutter/pages/calendar_page.dart';
import 'package:up_app_flutter/pages/events_page.dart';
import 'package:up_app_flutter/pages/map_page.dart';
import 'package:up_app_flutter/pages/schedule_form_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final calendarNavKey = GlobalKey<NavigatorState>();
  final mapNavKey = GlobalKey<NavigatorState>();
  final homeNavKey = GlobalKey<NavigatorState>();
  final eventsNavKey = GlobalKey<NavigatorState>();
  final scheduleNavKey = GlobalKey<NavigatorState>();
  int selectedTab = 2;
  List<NavModel> items = [];

  @override
  void initState() {
    super.initState();
    items = [
      NavModel(
          page: const CalendarPage(title: 'Calendario'),
          navigatorKey: calendarNavKey),
      NavModel(page: const MapPage(title: 'Croquis'), navigatorKey: mapNavKey),
      NavModel(
          page: const HomePage(title: 'Principal'), navigatorKey: homeNavKey),
      NavModel(
          page: const EventsPage(title: "Eventos"), navigatorKey: eventsNavKey),
      NavModel(
          page: const ScheduleFormPage(), navigatorKey: scheduleNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (items[selectedTab].navigatorKey.currentState?.canPop() ?? false) {
          items[selectedTab].navigatorKey.currentState?.pop();
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedTab,
          children: items
              .map((page) => Navigator(
                    key: page.navigatorKey,
                    onGenerateInitialRoutes: (navigator, initialRoute) {
                      return [
                        MaterialPageRoute(builder: (context) => page.page)
                      ];
                    },
                  ))
              .toList(),
        ),
        bottomNavigationBar: NavBar(
          pageIndex: selectedTab,
          onTap: (index) {
            if (index == selectedTab) {
              items[index]
                  .navigatorKey
                  .currentState
                  ?.popUntil((route) => route.isFirst);
            } else {
              setState(() {
                selectedTab = index;
              });
            }
          },
        ),
      ),
    );
  }
}
