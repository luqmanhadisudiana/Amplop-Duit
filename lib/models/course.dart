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
  // bool isDone;
  int savedAnswer;

  QuestionAnswer(
      {required this.question,
      required this.answerList,
      // this.isDone = false,
      this.savedAnswer = -1});
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
      videoThumbail:
          "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/thumbnail/Thumbnail%20Amplop%20Duit%20Ep%201.png",
      ytVideoID:
          "n9pFVCWKbB4", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
      feedback: 0,
      listQuestionAnswer: [
        QuestionAnswer(
            question:
                "Dari video sebelumnya, berikut apa aspek yang harus diperhatikan dalam mencatat keuangan?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(text: "Tanggal, Deskripsi, Nominal", status: false),
              Answer(text: "Uang, Keluar, dan Masuk", status: false),
              Answer(text: "Hanya hasil beli barang saja", status: true),
              Answer(text: "Tidak perlu dicatat", status: false),
            ]),
        QuestionAnswer(question: "Apa yang dimaksud deskripsi?", answerList: [
          // salah satu harus true karena jawaban
          Answer(text: "Penjelasan mata uang yang dikeluarkan", status: true),
          Answer(
              text: "Penjelasan berapa uang yang dikeluarkan", status: false),
          Answer(text: "Penjelasan untuk apa uang dikeluarkan", status: false),
          Answer(text: "Tidak perlu dicatat", status: false),
        ]),
        QuestionAnswer(
            question:
                "Apa yang harus dilakukan pada akhir setiap bulan dalam metode Kakeibo?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(text: "Menambahkan lebih banyak utang", status: false),
              Answer(text: "Menyimpan uang yang tersisa", status: true),
              Answer(text: "Mengabaikan perhitungan", status: false),
              Answer(text: "Membeli barang-barang mewah", status: false),
            ]),
        QuestionAnswer(
            question:
                "Apa yang harus dilakukan sebelum membuat rencana pengeluaran bulanan dalam Kakeibo?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(text: "Menjadi boros", status: false),
              Answer(text: "Mengabaikan pendapatan bulanan", status: false),
              Answer(
                  text: "Mengetahui jumlah pengeluaran bulanan", status: true),
              Answer(text: "Tidak melakukan perencanaan", status: false),
            ]),
        QuestionAnswer(
            question:
                "Apa yang menjadi tujuan utama dari metode pencatatan keuangan Kakeibo?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(text: "Mencari keuntungan besar", status: false),
              Answer(
                  text: "Mencatat pengeluaran harian dengan teliti",
                  status: true),
              Answer(text: "Mengumpulkan uang secara efisien", status: false),
              Answer(text: "Mengabaikan pengeluaran", status: false),
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
      videoThumbail:
          "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/thumbnail/Thumbnail%20Amplop%20Duit%20Ep%202.png",
      ytVideoID:
          "MCDKOER9b7A", // https://www.youtube.com/watch?v={VideoID}, contoh https://www.youtube.com/watch?v=mq8ZLUBdQHQ
      feedback: 0,
      listQuestionAnswer: [
        QuestionAnswer(
            question: "Apa tujuan utama dari metode keuangan kakeibo?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(text: "Membuat keuangan lebih rumit", status: false),
              Answer(text: "Meningkatkan kesadaran finansial", status: true),
              Answer(text: "Mengabaikan anggaran", status: false),
              Answer(text: "Menyembunyikan pengeluaran", status: false),
            ]),
        QuestionAnswer(
            question:
                "Bagaimana kakeibo membantu dalam mengendalikan pengeluaran bulanan?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(text: "Mengabaikan anggaran", status: false),
              Answer(text: "Merencanakan anggaran bulanan", status: true),
              Answer(text: "Menyembunyikan sumber pendapatan", status: false),
              Answer(text: "Tidak memperhitungkan pengeluaran", status: false),
            ]),
        QuestionAnswer(
            question:
                "Apa perbedaan utama antara kakeibo dan metode pengelolaan keuangan tradisional?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(
                  text: "Keduanya memiliki pendekatan yang sama",
                  status: false),
              Answer(
                  text:
                      "Kakeibo fokus pada penghematan, sedangkan metode tradisional tidak",
                  status: true),
              Answer(text: "Metode tradisional lebih rumit", status: false),
              Answer(
                  text: "Kakeibo tidak melibatkan perencanaan keuangan",
                  status: false),
            ]),
        QuestionAnswer(
            question:
                "Apa manfaat utama dari kesadaran finansial yang diperoleh melalui kakeibo?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(
                  text: "Meningkatkan pengeluaran secara impulsif",
                  status: false),
              Answer(
                  text: "Memperoleh kontrol lebih baik atas keuangan pribadi",
                  status: true),
              Answer(
                  text: "Mengabaikan kebutuhan darurat keuangan",
                  status: false),
              Answer(
                  text: "Tidak memperhatikan rencana keuangan jangka panjang",
                  status: false),
            ]),
        QuestionAnswer(
            question:
                "Bagaimana kakeibo membantu dalam mencapai tujuan keuangan jangka panjang?",
            answerList: [
              // salah satu harus true karena jawaban
              Answer(
                  text: "Dengan mengabaikan rencana keuangan", status: false),
              Answer(text: "Mengandalkan keberuntungan", status: false),
              Answer(
                  text:
                      "Melalui perencanaan dan pengelolaan keuangan yang bijaksana",
                  status: true),
              Answer(text: "Tanpa perlu merinci pengeluaran", status: false),
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
      videoThumbail:
          "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/thumbnail/Thumbnail%20Amplop%20Duit%20Ep%203.png",
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
      videoThumbail:
          "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/thumbnail/Thumbnail%20Amplop%20Duit%20Ep%204.png",
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
      videoThumbail:
          "https://raw.githubusercontent.com/luqmanhadisudiana/Amplop-Duit/main/assets/img/thumbnail/Thumbnail%20Amplop%20Duit%20Ep%205.png",
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
