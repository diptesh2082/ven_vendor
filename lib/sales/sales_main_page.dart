import 'dart:ffi';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vyam_vandor/Screens/sales/activebooking.dart';
import 'package:vyam_vandor/constants.dart';
import 'package:vyam_vandor/sales/sales_7days.dart';
import 'package:vyam_vandor/sales/sales_all_time.dart';
import 'package:vyam_vandor/sales/sales_month.dart';


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

  void dropDownPackage(String? selecetValue){
    // if(selecetValue is String){
    setState(() {
      // packageType=selecetValue;
      // Select_Package_type=selecetValue;
    });
    // }
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = DateFormat('dd MMMM, yyyy').format(args.value);
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {

      });
    });
  }
  //
  void _selectedDataChange(DateRangePickerSelectionChangedArgs args)
  {
        print(args.value);
        DateTime sDate = args.value.startDate;
        DateTime eDate = args.value.endDate;

        // setState((){
            startDate = sDate;
            endDate = eDate;

            print(startDate);
            print(endDate);
        // }
        // );
  }

  void _show() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        content: Card(
          child: SizedBox(
            height: 500,
            // width: MediaQuery.of(context).size.width*.99,
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
    ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBackgroundColor,
      appBar: AppBar(
        toolbarHeight: 60,
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

          Column(
            children: [
              SizedBox(
                height: 9,
              ),
              Container(
                // color: Colors.white,
                width: 100,
                // height: 10,
                child: Column(
                  children: [
                    DropdownButton(
                        iconSize: 25,
                        elevation: 8,
                        iconDisabledColor: Colors.red,
                        iconEnabledColor: Colors.red,
                        // underline: SizedBox(),
                        hint: Text("Filter",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),
                        items:  [
                          DropdownMenuItem(child: Text("pay per ses",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "pay per session",),
                          DropdownMenuItem(child: Text("package",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "package",),
                          DropdownMenuItem(child: Text("pay per ses",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "pay per session",),
                          DropdownMenuItem(child: Text("pay per ses",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "pay per session",),
                        ], onChanged: dropDownPackage),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 3,
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.date_range,
          //     color: Colors.black,
          //   ),
          //   onPressed: () {
          //     _show();
          //
          //   },
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0,0,0,0),
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
          // SizedBox(
          //   width: 100,
          //   child: DropdownButton(
          //         iconSize: 15,
          //         elevation: 8,
          //           hint: Text("Filter",
          //             textAlign: TextAlign.center,
          //             style: GoogleFonts.poppins(
          //             fontSize: 12,
          //             fontWeight: FontWeight.w400
          //           ),),
          //           items:  [
          //             DropdownMenuItem(child: Text("pay per ses",style: GoogleFonts.poppins(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w400
          //             ),),value: "pay per session",),
          //             DropdownMenuItem(child: Text("package",style: GoogleFonts.poppins(
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w400
          //             ),),value: "package",),
          //           ], onChanged: dropDownPackage),
          // ),
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
      ),
    );
  }
}
