import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/bookings/bookings_active.dart';
import 'package:vyam_vandor/bookings/bookings_completed.dart';
import 'package:vyam_vandor/bookings/bookings_upcoming.dart';
import 'package:vyam_vandor/constants.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kAppbarBackgroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: kAppBarIconColor,
          ),
        ),
        title: Text(
          'Bookings',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                    kDefaultPadding - 3, 10, kDefaultPadding - 3, 24),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonsTabBar(
                    backgroundColor: Colors.black,
                    unselectedBackgroundColor: Colors.white,
                    labelStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 11, horizontal: kDefaultPadding),
                    unselectedLabelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    radius: 8,
                    tabs: const [
                      Tab(
                        text: 'Upcoming',
                      ),
                      Tab(
                        text: 'Active',
                      ),
                      Tab(
                        text: 'Completed',
                      ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height - 160,
                  child: const TabBarView(
                    children: [
                      UpcomingBookings(),
                      ActiveBookings(),
                      CompletedBookings(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
