class Answer {
  final String text;
  final bool status;

  Answer({
    required this.text,
    required this.status,
  });
}

class QuestionAnswer {
  final String question;
  final List<Answer> answerList;
  bool isDone;

  QuestionAnswer({
    required this.question,
    required this.answerList,
    this.isDone = false,
  });
}

class Headline {
  final String title, desc;

  Headline({required this.title, required this.desc});
}

class Course {
  final int id;
  final Headline headline;
  final String title, description, videoThumbail, ytVideoID;
  final List<QuestionAnswer> listQuestionAnswer;
  int feedback;

  Course(
      {required this.id,
      required this.headline,
      required this.title,
      required this.description,
      required this.videoThumbail,
      required this.ytVideoID,
      required this.listQuestionAnswer,
      this.feedback = 0});
}

// Data Dummy
var courseList = [
  // course level
  Course(
      id: 1,
      headline: Headline(
          title: "Level 1 , Bagian 1",
          desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
      title: "Membuat Catatan Keuangan Pribadi",
      description:
          "Pernah tidak sih uang kalian habis di akhir bulan, saldo atm yang kosong, celengan gak ada isinya , bahkan kalian cuman makan Mie Instan. Tanpa mengetahui uang kalian habis dimana saja.\n\nMenurut kalian kenapa sih uang kalian cepat habis? Ayo tonton video pembelajaran kali ini!",
      videoThumbail: "assets/img/thumbnail/Thumbnail Amplop Duit Ep 1.png",
      ytVideoID:
          "mq8ZLUBdQHQ", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
      feedback: 0,
      listQuestionAnswer: [
        QuestionAnswer(question: "Ini Pertanyaan 1", answerList: [
          // salah satu harus true karena jawaban
          Answer(text: "Jawaban 1", status: true),
          Answer(text: "Jawaban 2", status: false),
          Answer(text: "Jawaban 3", status: false),
          Answer(text: "Jawaban 4", status: false),
        ]),
        QuestionAnswer(question: "Ini Pertanyaan 2", answerList: [
          // salah satu harus true karena jawaban
          Answer(text: "Jawaban 1", status: true),
          Answer(text: "Jawaban 2", status: false),
          Answer(text: "Jawaban 3", status: false),
          Answer(text: "Jawaban 4", status: false),
        ]),
        QuestionAnswer(question: "Ini Pertanyaan 3", answerList: [
          // salah satu harus true karena jawaban
          Answer(text: "Jawaban 1", status: true),
          Answer(text: "Jawaban 2", status: false),
          Answer(text: "Jawaban 3", status: false),
          Answer(text: "Jawaban 4", status: false),
        ]),
        QuestionAnswer(question: "Ini Pertanyaan 4", answerList: [
          // salah satu harus true karena jawaban
          Answer(text: "Jawaban 1", status: true),
          Answer(text: "Jawaban 2", status: false),
          Answer(text: "Jawaban 3", status: false),
          Answer(text: "Jawaban 4", status: false),
        ]),
        QuestionAnswer(question: "Ini Pertanyaan 5", answerList: [
          // salah satu harus true karena jawaban
          Answer(text: "Jawaban 1", status: true),
          Answer(text: "Jawaban 2", status: false),
          Answer(text: "Jawaban 3", status: false),
          Answer(text: "Jawaban 4", status: false),
        ]),
      ]),
];
