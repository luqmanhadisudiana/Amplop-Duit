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

class Course {
  final int id;
  final String title, description, ytVideoID;
  final List<QuestionAnswer> listQuestionAnswer;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.ytVideoID,
    required this.listQuestionAnswer,
  });
}

// Data Dummy
var courseList = [
  // satu course level
  Course(
      id: 1,
      title: "title",
      description: "description",
      ytVideoID:
          "mq8ZLUBdQHQ", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
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
