class Achievement {
  final String title, desc, imageUrl;
  final int currentValue, maxValue;

  Achievement({
    required this.title,
    required this.desc,
    required this.imageUrl,
    required this.currentValue,
    required this.maxValue,
  });
}

// Dummy Achievement

var achievementData = [
  Achievement(
      title: "Konsisten",
      desc: "Login 5 Hari Beruntun",
      imageUrl: "assets/img/pencapaian/Konsisten.svg",
      currentValue: 4,
      maxValue: 5),
  Achievement(
      title: "Master",
      desc: "Dapatkan 3000 poin!",
      imageUrl: "assets/img/pencapaian/Master.png",
      currentValue: 2805,
      maxValue: 3000),
  Achievement(
      title: "Ilmuwan",
      desc: "Dapatkan 6000 poin!",
      imageUrl: "assets/img/pencapaian/Ilmuwan.png",
      currentValue: 2805,
      maxValue: 6000),
  Achievement(
      title: "Membara",
      desc: "Capai runtunan 30 hari",
      imageUrl: "assets/img/pencapaian/Membara.svg",
      currentValue: 28,
      maxValue: 30),
  Achievement(
      title: "Penguasa Kegelapan",
      desc: "Selesaikan 5 pelajaran setelah jam 10 malam",
      imageUrl: "assets/img/pencapaian/Penguasa Kegelapan.png",
      currentValue: 4,
      maxValue: 5),
  Achievement(
      title: "Juara",
      desc: "Maju ke liga selanjutnya dengan peringkat 3 besar",
      imageUrl: "assets/img/pencapaian/Juara.png",
      currentValue: 4,
      maxValue: 5),
  Achievement(
      title: "Pemenang",
      desc: "Raih peringkat #1 di papan skor",
      imageUrl: "assets/img/pencapaian/Pemenang.svg",
      currentValue: 0,
      maxValue: 1),
];
