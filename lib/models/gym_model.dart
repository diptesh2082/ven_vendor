class GymModel {
  final int id;
  final String name;
  final String location;
  final String address;
  final String review;
  final String image;
  final double lat;
  final double lon;

  GymModel(
      {required this.id,
      required this.name,
      required this.location,
      required this.address,
      required this.review,
      required this.image,
      required this.lat,
      required this.lon});
}

