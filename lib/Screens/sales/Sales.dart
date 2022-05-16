import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vyam_vandor/constants.dart';
import 'package:vyam_vandor/sales/allSales.dart';
import 'package:vyam_vandor/sales/sales_7days.dart';
import 'package:vyam_vandor/sales/sales_all_time.dart';
import 'package:vyam_vandor/sales/sales_month.dart';

import '../../bookings/bookings_upcoming.dart';
import 'DaysFilter.dart';

class Sales extends StatefulWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: kScaffoldBackgroundColor,
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: kAppBarIconColor,
          ),
        ),
        title: Text(
          'Sales',
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
                padding: EdgeInsets.fromLTRB(kDefaultPadding-3, 10, kDefaultPadding-3, kDefaultPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonsTabBar(
                    backgroundColor: Colors.black,
                    unselectedBackgroundColor: Colors.white,
                    labelStyle:GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 11, horizontal: kDefaultPadding),
                    unselectedLabelStyle:GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    radius: 8,
                    tabs: const [
                      Tab(text: 'AllTime',),
                      Tab(text: '7 Days',),
                      Tab(text: 'Month',),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height-160,
                  child:  TabBarView(
                    children: [
                      AllSales(),
                      DaysFilter(filter: "7",),
                      DaysFilter(filter: "30",),
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
