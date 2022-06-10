import 'dart:ffi';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
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
  DateTimeRange? selectDateTime=DateTimeRange(
  start: DateTime(2018),
  end:DateTime(2030),
  ) ;
  String? _selectedDate;

  DateTime? endDate;
  String? selectedType ="all";
  Future<void> dropDownPackage(String? selecetValue) async {
    if(selecetValue == "all"){
    setState(() {
      selectedType=selecetValue;
      selectDateTime=DateTimeRange(
        start: DateTime(2018),
        end:DateTime(2030),
      ) ;

    });
    }
    if(selecetValue == "7"){
      setState(() {
        selectedType=selecetValue;
        selectDateTime=DateTimeRange(
          start: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day-7),
          end:DateTime.now(),
        ) ;

      });
    }
    if(selecetValue == "30"){
      setState(() {
        selectedType=selecetValue;
        selectDateTime=DateTimeRange(
          start: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day-30),
          end:DateTime.now(),
        ) ;

      });
    }
    if(selecetValue == "custom"){
    final DateTimeRange?  x =await showDateRangePicker(context: context, firstDate: DateTime(2022 , 1), lastDate: DateTime(2030 , 12 ,31),
          currentDate: DateTime.now(),
          saveText: 'Done'
      );
      setState(()  {
        selectedType=selecetValue;
        selectDateTime=x;

      });

    }
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    _selectedDate = DateFormat('dd MMMM, yyyy').format(args.value);
    SchedulerBinding.instance!.addPostFrameCallback((duration) {
      setState(() {

      });
    });
  }
  //
  DateTimeRange? timings;
  String? range="0";
  void _selectedDataChange(DateRangePickerSelectionChangedArgs args)
  {
        print(args.value);
        DateTime sDate = args.value.startDate;
        DateTime eDate = args.value.endDate;

        // setState((){
        //     startDate = sDate;
        //     endDate = eDate;
        //     range=endDate?.difference(startDate!).inDays.toString();

            // print(startDate);
            print(endDate);
        // }
        // );
  }
  // void getDay()async{
  //   _show();
  //
  // }

 //  Future dateRange()async{
 //
 //    DateTimeRange? newDateRaange = await showDateRangePicker(
 //        context: context,
 //        firstDate: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day-60),
 //        lastDate: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+60),)
 //
 //  }
 //  DateTimeRange initialDateRange= DateTimeRange(
 //    start: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day-60),
 //    end:DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+60),
 //  ) ;
 // showRange() async {
 //
 //
 //   // final new_date_range= await ();
 //   // return startDate;
 //    // );
 //  }
 //  void _show()async
 //  {
 //    final DateTimeRange? result = await showDateRangePicker(context: context, firstDate: DateTime(2022 , 1), lastDate: DateTime(2030 , 12 ,31),
 //        currentDate: DateTime.now(),
 //        saveText: 'Done'
 //    );
 //    if(result != null)
 //    {
 //      print(result.start.toString());
 //      setState(() {
 //        _selectDateTime = result;
 //      });
 //    }
 //  }
  DateTimeRange _selectDateTime= DateTimeRange(
    start: DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day-60),
    end:DateTime.utc(DateTime.now().year,DateTime.now().month,DateTime.now().day+60),
  ) ;
  void _show()async
  {
    final DateTimeRange? result = await showDateRangePicker(context: context, firstDate: DateTime(2022 , 1), lastDate: DateTime(2030 , 12 ,31),
        currentDate: DateTime.now(),
        saveText: 'Done'
    );
    if(result != null)
    {
      print(result.start.toString());
      setState(() {
        _selectDateTime = result;
      });
    }
  }

  final Color _maleColor = HexColor("292F3D");
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
        title: InkWell(
          onTap: (){
            print(_selectDateTime.toString());
          },
          child: Text(
            'Bookings',
            style: TextStyle(
              fontFamily: kFontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
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
                width: 102,
                // height: 10,
                child: Column(
                  children: [
                    DropdownButton(
                        iconSize: 25,
                        elevation: 8,
                        iconDisabledColor: Colors.red,
                        iconEnabledColor: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                        // underline: SizedBox(),
                        hint: Text("Filter",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                          ),),
                        items:  [
                          DropdownMenuItem(child: Text("All",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "all",),
                          DropdownMenuItem(child: Text("7 days",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "7",),
                          DropdownMenuItem(child: Text("1 month",style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w400
                          ),),value: "30",),
                          DropdownMenuItem(

                              child:
                          Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                color: Colors.black87,
                                size: 12,
                              ),
                              Text("custom",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black87,
                              fontWeight: FontWeight.w400
                              ),),
                            ],
                          ), value: "custom"),
                        ], onChanged: dropDownPackage),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 5,
          ),

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
                      backgroundColor: _maleColor,
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
                          text: 'Active',
                        ),
                        Tab(
                          text: 'Completed',
                        ),
                        Tab(
                          text: 'All',
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

                        ActivBookings(filter: selectDateTime,),
                        MonthSales(filter: selectDateTime),
                        UpcomingBookings(filter: selectDateTime,),
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
