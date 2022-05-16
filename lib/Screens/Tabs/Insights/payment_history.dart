import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/payments/allTimePayment.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/payments/day7pay.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/payments/monthpay.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  _PaymentHistoryState createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  var _getIndex = 0;

  bool _allTime = true;
  // ignore: non_constant_identifier_names
  bool _7Days = false;
  bool month = false;

  final Color _inactiveColor = HexColor("FFFFFF");
  final Color _maleColor = HexColor("292F3D");
  final Color _textInactive = HexColor("3A3A3A");
  final Color _textActive = HexColor("FFFFFF");

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: HexColor("F5F5F5"),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              CupertinoIcons.back,
              color: HexColor("3A3A3A"),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          bottom: TabBar(
              indicatorColor: HexColor("F5F5F5"),
              onTap: (index) {
                _getIndex = index;
                if (_getIndex == 0) {
                  setState(() {
                    _allTime = true;
                    _7Days = false;
                    month = false;
                  });
                }
                if (_getIndex == 1) {
                  setState(() {
                    _allTime = false;
                    _7Days = true;
                    month = false;
                  });
                }
                if (_getIndex == 2) {
                  setState(() {
                    _allTime = false;
                    _7Days = false;
                    month = true;
                  });
                }
                if (_getIndex == 3) {
                  setState(() {
                    _allTime = false;
                    _7Days = false;
                    month = false;
                  });
                }
              },
              tabs: [
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _allTime ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "All time",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _allTime ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: _7Days ? _maleColor : _inactiveColor),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                      child: Center(
                        child: Text(
                          "7 days",
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                              color: _7Days ? _textActive : _textInactive),
                        ),
                      ),
                    )),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: month ? _maleColor : _inactiveColor),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 11.0, bottom: 11.0),
                    child: Center(
                      child: Text(
                        "15 days",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                            color: month ? _textActive : _textInactive),
                      ),
                    ),
                  ),
                ),
              ]),
          toolbarHeight: 80,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Payment history",
            style: GoogleFonts.poppins(
                color: HexColor("3A3A3A"),
                fontSize: 18,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [AllTimePay(), Day7Pay(), MonthPay()]),
      ),
    );
  }
}
