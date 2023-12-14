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
  int selectedAnswer;

  QuestionAnswer(
      {required this.question,
      required this.answerList,
      this.isDone = false,
      this.selectedAnswer = -1});
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

// Eps 1 https://youtu.be/n9pFVCWKbB4
// Eps 2 https://youtu.be/MCDKOER9b7A
// Eps 3 https://youtu.be/NTCY5rZRcDo
// Eps 4 https://youtu.be/X7i1W3WVqoQ
// Eps 5 https://youtu.be/V-vNKONcJmc

var yTVideoID = [
  "n9pFVCWKbB4",
  "MCDKOER9b7A",
  "NTCY5rZRcDo",
  "X7i1W3WVqoQ",
  "V-vNKONcJmc"
];

// Data Dummy
var courseList = [
  // course level
  Course(
      id: 1,
      headline: Headline(
          title: "Level 1",
          desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
      title: "Membuat Catatan Keuangan Pribadi",
      description:
          "Pernah tidak sih uang kalian habis di akhir bulan, saldo atm yang kosong, celengan gak ada isinya, bahkan kalian cuman makan Mie Instan. Tanpa mengetahui uang kalian habis dimana saja.\n\nMenurut kalian kenapa sih uang kalian cepat habis? Ayo tonton video pembelajaran kali ini!",
      videoThumbail: "assets/img/thumbnail/Thumbnail Amplop Duit Ep 1.png",
      ytVideoID:
          "n9pFVCWKbB4", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
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
  // course level
  Course(
      id: 2,
      headline: Headline(
          title: "Level 2",
          desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
      title: "Kakeibo",
      description:
          "Kakeibo adalah salah satu metode pencatatan keuangan yang berasal dari Jepang. diperkenalkan pada tahun 1904 oleh Makoto Hani dan dipopulerkan oleh Fumiko Chiba berjudul Kakeibo: The Japanese Art of Saving Money. \n\nDi Kakeibo terdapat 4 pertanyaan penting yang perlu kalian jawab jika ingin mengatur keuangan. Yuk, simak video Amplop Duit berikut.",
      videoThumbail: "assets/img/thumbnail/Thumbnail Amplop Duit Ep 2.png",
      ytVideoID:
          "MCDKOER9b7A", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
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
  // course level
  Course(
      id: 3,
      headline: Headline(
          title: "Level 3",
          desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
      title: "Kondisi Keuangan",
      description:
          "Buat kalian yang pernah belajar ekonomi mungkin kalian tahu dalam perusahaan aset = modal + hutang. (tahu ngga hubungannya dengan kondisi keuangan kalian?) Sama halnya dengan perusahaan, kalian harus mengetahui kondisi keuangan kalian sendiri. Kalian bisa mengetahui jumlah utang, jumlah aset kalian dengan cara menghitungnya sehingga kalian bisa tahu apa yang bisa dikurangi atau ditambah dari diri kalian dan juga uangnya.",
      videoThumbail: "assets/img/thumbnail/Thumbnail Amplop Duit Ep 3.png",
      ytVideoID:
          "NTCY5rZRcDo", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
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
  // course level
  Course(
      id: 4,
      headline: Headline(
          title: "Level 4",
          desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
      title: "Asset",
      description:
          "Kalian pasti punya tempat tinggal, kendaraan bermotor, hp, saham, emas, uang rupiah atau mata uang asing kan. \nNah itu semua termasuk bagian dari  aset. \n\nTrus apa sih asset? \n\nYuk, nonton video Amplop Duit untuk mendapatkan ilmu lebih dalam.",
      videoThumbail: "assets/img/thumbnail/Thumbnail Amplop Duit Ep 4.png",
      ytVideoID:
          "X7i1W3WVqoQ", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
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
  Course(
      id: 5,
      headline: Headline(
          title: "Level 5",
          desc: "Memahami Fundamental Pengelolaan Keuangan Pribadi"),
      title: "Modal",
      description:
          "Kalian pasti punya mobil, rumah, surat berharga,investasi atau tabungan kan?\nIni semua adalah networth kalian. Buat kalian yang sudah menonton video tentang asset pasti sama dong barang-barangnya Trus apa sih bedanya modal dengan Aset? Mari saksikan videonya.\n\nNetworth adalah keseluruhan asset yang telah dikurangin oleh nilai kredit atau sewa. Networth menjadi tolak ukur kesehatan finansial seseorang. Dari sini kalian bisa tahu jika modal lebih besar ketimbang hutang maka finansial bisa dikatakan sehat. Sedangkan jika hutang kalian lebih besar ketimbang modal maka finansial tidak sehat.\n\nTonton video berikut agar kamu lebih pintar dalam pengetahuan soal modal.",
      videoThumbail: "assets/img/thumbnail/Thumbnail Amplop Duit Ep 5.png",
      ytVideoID:
          "V-vNKONcJmc", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
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
