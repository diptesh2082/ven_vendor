import 'dart:ffi';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vyam_vandor/Screens/sales/activebooking.dart';
import 'package:vyam_vandor/constants.dart';
import 'package:vyam_vandor/sales/sales_7days.dart';
import 'package:vyam_vandor/sales/sales_all_time.dart';
import 'package:vyam_vandor/sales/sales_month.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../bookings/bookings_upcoming.dart';

class TotalBookings extends StatefulWidget {
  const TotalBookings({Key? key}) : super(key: key);

  @override
  _TotalBookingsState createState() => _TotalBookingsState();
}

class _TotalBookingsState extends State<TotalBookings> {
  DateTimeRange? _selectDateTime;
  String? _selectedDate;
  DateTime? startDate;
  DateTime? endDate;

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = DateFormat('dd MMMM, yyyy').format(args.value);
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {});
    });
  }

  void _selectedDataChange(DateRangePickerSelectionChangedArgs args)
  {
        print(args.value);
        DateTime sDate = args.value.startDate;
        DateTime eDate = args.value.endDate;

        setState((){
            startDate = sDate;
            endDate = eDate;

            print(startDate);
            print(endDate);
        }
        );
  }

  void _show() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Card(
          child: SfDateRangePicker(
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            selectionTextStyle: const TextStyle(color: Colors.white),
            selectionColor: Colors.blue,
            startRangeSelectionColor: Colors.yellow,
            endRangeSelectionColor: Colors.yellow,
            rangeSelectionColor: Colors.yellowAccent,
            showActionButtons: true,

              onSelectionChanged: _selectedDataChange,
          ),
        ),
    ),
    );
  }

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
          'Bookings',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.date_range,
              color: Colors.black,
            ),
            onPressed: () {
              _show();

            },
          ),
        ],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(kDefaultPadding - 3, 10,
                    kDefaultPadding - 3, kDefaultPadding),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: ButtonsTabBar(
                    backgroundColor: Colors.black,
                    unselectedBackgroundColor: Colors.white,
                    labelStyle: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 11, horizontal: kDefaultPadding),
                    unselectedLabelStyle: GoogleFonts.poppins(
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
                  child: TabBarView(
                    children: [
                      UpcomingBookings(),
                      ActivBookings(),
                      MonthSales(),
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
