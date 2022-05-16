import 'package:get/get.dart';

import '../models/gym_model.dart';
// import 'package:vyam/models/gym_model.dart';

class GymController extends GetxController{

List <GymModel> gymLists = [
  GymModel(id: 1, name: "Transfomer Gym", location: "Barakar 0.3KM", address: "Bus stand, Barakar", review: "4.7 (113 reviews)", image: "assets/photos/gym.jpg", lat: 23.7264376, lon: 86.8434882),
  GymModel(id: 2, name: "Fitness Fantasy", location: "Asansol 1.3 KM", address: "Ashram more, asansol", review: "5.0 (13 reviews)", image: "assets/photos/gym.jpg", lat: 23.6828365, lon: 86.9816039),
  GymModel(id: 3, name: "GymX Studios", location: "Asansol 2.3", address: "Bus stand, Barakar", review: "4.7 (13 reviews)", image: "assets/photos/gym.jpg", lat: 23.6823747, lon: 86.9817005),
];
}
class BookingController extends GetxController{
  var booking=0.obs;
  var review=0.0.obs;
  var star1=0.0.obs;
  var star2=0.0.obs;
  var star3=0.0.obs;
  var star4=0.0.obs;
  var star5=0.0.obs;
  var review_number=0.obs;
  RxString search="".obs;
}