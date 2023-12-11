import 'package:faker/faker.dart';

class Leaderboard {
  final String imageUser, nameUser;
  final int point;

  Leaderboard({
    required this.imageUser,
    required this.nameUser,
    required this.point,
  });
}

final faker = Faker.withGenerator(random);

var dummyLeaderboard = [
  for (var i = 0; i < 20; i++)
    Leaderboard(
      imageUser: faker.image.image(random: true),
      nameUser: faker.person.name(),
      point: 669 - i,
    ),
];
