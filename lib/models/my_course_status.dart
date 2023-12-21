class MyCourseStatus {
  int heart, diamond;

  MyCourseStatus({required this.heart, required this.diamond});

  Map<String, dynamic> toMap() {
    return {
      'heart': heart,
      'diamond': diamond,
    };
  }

  factory MyCourseStatus.fromMap(Map<String, dynamic> map) {
    return MyCourseStatus(
      heart: map['heart'],
      diamond: map['diamond'],
    );
  }

  void reset() {
    heart = 0;
    diamond = 0;
  }
}
