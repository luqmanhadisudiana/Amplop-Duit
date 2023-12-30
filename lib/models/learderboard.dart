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
  for (var i = 0; i < 19; i++)
    Leaderboard(
      imageUser: faker.image.image(random: true),
      nameUser: faker.person.name(),
      point: 669 - i,
    ),
];

List<Leaderboard> sortLeaderboards(List<Leaderboard> leaderboards,
    {bool descending = true}) {
  leaderboards.sort((a, b) =>
      descending ? b.point.compareTo(a.point) : a.point.compareTo(b.point));
  return leaderboards;
}
