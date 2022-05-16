import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/yoga.dart';
import 'package:vyam_vandor/Screens/Tabs/Insights/zumba.dart';

import 'gyms.dart';
// import 'package:vyam/Insights/gyms.dart';
// import 'package:vyam/Insights/yoga.dart';
// import 'package:vyam/Insights/zumba.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: '2972 Westhelmer Rd, Illinois 85686',
            hintStyle: const TextStyle(fontWeight: FontWeight.bold),
            prefixIcon: SvgPicture.asset(
              'assets/Icons/Location.svg',
              fit: BoxFit.none,
            ),
            suffixIcon: SvgPicture.asset(
              'assets/Icons/notification.svg',
              fit: BoxFit.none,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: const TextStyle(fontWeight: FontWeight.bold),
                prefixIcon: SvgPicture.asset(
                  'assets/Icons/Search.svg',
                  fit: BoxFit.none,
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 150,
                child: Row(
                  children: [
                    Image.asset('assets/cards/50% off.png'),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset('assets/cards/yoga classes.png'),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: 150,
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyGyms()));
                        },
                        child: Image.asset('assets/cards/gym.png')),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyZumba()));
                        },
                        child: Image.asset('assets/cards/zumba.png')),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyYoga()));
                        },
                        child: Image.asset('assets/cards/yoga.png')),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Center(
              child: Text("No nearby gyms in your area"),
            )
          ],
        ),
      ),
    );
  }
}
