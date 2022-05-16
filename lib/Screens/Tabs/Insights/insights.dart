import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_vandor/sales/sales_7days.dart';
import 'package:vyam_vandor/sales/sales_all_time.dart';

import '../../../sales/sales_month.dart';
import 'days/allTime.dart';
import 'days/days15.dart';
import 'days/days30.dart';
import 'days/days7.dart';

class InsightsTab extends StatefulWidget {
  const InsightsTab({Key? key}) : super(key: key);

  @override
  State<InsightsTab> createState() => _InsightsTabState();
}

class _InsightsTabState extends State<InsightsTab> {
  var _getIndex = 0;

  bool _allTime = true;
  // ignore: non_constant_identifier_names
  bool _7Days = false;
  // ignore: non_constant_identifier_names
  bool _15Days = false;
  // ignore: non_constant_identifier_names
  bool _30Days = false;

  final Color _inactiveColor = HexColor("FFFFFF");
  final Color _maleColor = HexColor("292F3D");
  final Color _textInactive = HexColor("3A3A3A");
  final Color _textActive = HexColor("FFFFFF");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: HexColor("F5F5F5"),
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(
          //     CupertinoIcons.back,
          //     color: HexColor("3A3A3A"),
          //   ),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          bottom: TabBar(
              indicatorColor: HexColor("F5F5F5"),
              onTap: (index) {
                _getIndex = index;
                if (_getIndex == 0) {
                  setState(() {
                    _allTime = true;
                    _7Days = false;
                    _15Days = false;
                    _30Days = false;
                  });
                }
                if (_getIndex == 1) {
                  setState(() {
                    _allTime = false;
                    _7Days = true;
                    _15Days = false;
                    _30Days = false;
                  });
                }
                if (_getIndex == 2) {
                  setState(() {
                    _allTime = false;
                    _7Days = false;
                    _15Days = true;
                    _30Days = false;
                  });
                }
                if (_getIndex == 3) {
                  setState(() {
                    _allTime = false;
                    _7Days = false;
                    _15Days = false;
                    _30Days = true;
                  });
                }
              },
              tabs: [
                Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _allTime ? _maleColor : _inactiveColor),
                    child: Center(
                      child: Text(
                        "All time",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: _allTime ? _textActive : _textInactive),
                      ),
                    )),
                Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _7Days ? _maleColor : _inactiveColor),
                    child: Center(
                      child: Text(
                        "7 days",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: _7Days ? _textActive : _textInactive),
                      ),
                    )),
                Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _15Days ? _maleColor : _inactiveColor),
                    child: Center(
                      child: Text(
                        "15 days",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: _15Days ? _textActive : _textInactive),
                      ),
                    )),
                Container(
                  width: 100,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: _30Days ? _maleColor : _inactiveColor),
                  child: Center(
                    child: Text(
                      "30 days",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          color: _30Days ? _textActive : _textInactive),
                    ),
                  ),
                ),
              ]),
          toolbarHeight: 72,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Insights",
            style: GoogleFonts.poppins(
                color: HexColor("3A3A3A"),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body:  TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [AllTime(), AllTimeSales(),DaysSales(),MonthSales(),]),
      ),
    );
  }
}




// Days_7(), Days_15(), Days_30()