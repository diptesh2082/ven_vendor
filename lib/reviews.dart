import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vyam_vandor/constants.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
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
          'Reviews',
          style: TextStyle(
            fontFamily: kFontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Reviews')
            .doc('GYM')
            .collection('Transformer Gym')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: EdgeInsets.all(kDefaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  child: Text(
                    'Last 7 days',
                    style: TextStyle(
                      fontFamily: kFontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    separatorBuilder: (context, index) => Divider(
                      height: kDividerHeight,
                      color: kDividerColor,
                    ),
                    itemBuilder: (context, index) {
                      String rating =
                          snapshot.data!.docs[index]['rating'].toString();
                      int rate_number = int.parse(rating);
                      if (rate_number == null) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kContainerColor,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                      future: FirebaseFirestore.instance
                                          .collection('user_details')
                                          .doc(snapshot.data!.docs[index]
                                              ['userId'])
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot2) {
                                        if (snapshot2.data == null) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                        return Text(
                                          snapshot2.data.get('name') ?? " ",
                                          style: TextStyle(
                                            fontFamily: kFontFamily,
                                            color: kReviewTextColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        );
                                      }),
                                  SizedBox(
                                    height: 10,
                                    width: 200,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: rate_number,
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          Icons.star,
                                          color: kRatingStarColor,
                                          size: 10,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          Divider(
                                        height: 2,
                                        color: kDividerColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: RichText(
                              text: TextSpan(
                                  text: snapshot.data!.docs[index]['title'],
                                  style: TextStyle(
                                    fontFamily: kFontFamily,
                                    color: kReviewTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: RichText(
                              text: TextSpan(
                                  text: snapshot.data!.docs[index]
                                      ['experience'],
                                  style: TextStyle(
                                    fontFamily: kFontFamily,
                                    color: kReviewTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
