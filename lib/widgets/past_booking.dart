import 'package:flutter/material.dart';

class PastBookingCard extends StatefulWidget {
  const PastBookingCard({
    Key? key,
    required this.userName,
    required this.bookingID,
    required this.bookingdate,
    required this.bookingPlan,
    required this.bookingPrice,
    required this.userID,
  }) : super(key: key);
  final String? userName;
  final String? bookingID;
  final String? bookingdate;
  final String? bookingPlan;
  final double? bookingPrice;
  final String? userID;

  @override
  State<PastBookingCard> createState() => _PastBookingCardState();
}

class _PastBookingCardState extends State<PastBookingCard> {
  @override
  void initState() {
    super.initState();
    print("//////////////////");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      height: 150,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Booking ID - ${widget.bookingID!}',
                style:
                    const TextStyle(fontWeight: FontWeight.w400, fontSize: 10),
              ),
              Text(
                widget.userName!,
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              Text(
                widget.bookingdate!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                widget.bookingPlan!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  '\$${widget.bookingPrice}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18),
                ),
              ),
              const Text(
                '12 days remaining',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Row(
                children: const [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: Colors.orange,
                  ),
                  SizedBox(
                    width: 3.5,
                  ),
                  Text(
                    'Completed',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
