class FacilitiesModel {
  final String image;
  final String name;
  final String address;

  FacilitiesModel(
      {required this.image, required this.name, required this.address});
}

List<FacilitiesModel> facilities = [
  FacilitiesModel(
      image: 'lib/assests/images/central_park.png',
      name: 'Central Park Hospital',
      address: 'London, UK'),
  FacilitiesModel(
      image: 'lib/assests/images/oakville.png',
      name: 'Oakville Hospital',
      address: 'Cape Town, South Africa')
];

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}