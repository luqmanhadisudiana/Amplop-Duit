import 'package:amplop_duit/component/appbar/course_appbar.dart';
import 'package:amplop_duit/component/button/main_button.dart';
import 'package:amplop_duit/component/customAlertDialog/custom_alert_dialog.dart';
import 'package:amplop_duit/models/my_course_status.dart';
import 'package:amplop_duit/provider.dart';
import 'package:amplop_duit/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:provider/provider.dart';

class CourseVideo extends StatefulWidget {
  final String ytVideoID, title, description;
  final int index, currentFeedback;
  const CourseVideo(
      {super.key,
      required this.title,
      required this.description,
      required this.ytVideoID,
      required this.index,
      required this.currentFeedback});

  @override
  State<CourseVideo> createState() => _CourseVideoState();
}

class _CourseVideoState extends State<CourseVideo> {
  late CourseProvider courseProvider;
  late MyCourseStatus myCourseStatusProvider;

  late YoutubePlayerController _controller;
  late String buttonText;
  late int feedback;

  void setFeedback(value) {
    setState(() {
      feedback = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.ytVideoID,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
    feedback = widget.currentFeedback;
    courseProvider = Provider.of<CourseProvider>(context, listen: false);
    myCourseStatusProvider =
        Provider.of<MyCourseStatus>(context, listen: false);
    debugPrint(courseProvider.getCourseFeedback(widget.index).toString());
    buttonText = courseProvider.getCourseFeedback(widget.index) == 0
        ? "Berikutnya"
        : "Kembali";
    debugPrint(widget.index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course',
      theme: MyAppTheme.buildTheme(),
      home: Scaffold(
          appBar: CourseAppbar(
              title: "My Course",
              // heartCount: 5,
              // diamondCount: 5,
              parentContext: context),
          body: ListView(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    YoutubePlayer(
                      controller: _controller,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.amber,
                        handleColor: Colors.amberAccent,
                      ),
                      onReady: () {
                        _controller.addListener(() {});
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Level ${widget.index + 1}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/Share-Outline.svg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    "Bagikan",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/Like-Outline.svg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    "Suka",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/icon/Dislike-Outline.svg",
                                    width: 16,
                                    height: 16,
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  const Text(
                                    "Tidak Suka",
                                    style: TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: Text(
                        widget.description,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: const Text(
                        "Feedback",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      child: const Text(
                        "Berapa nilai untuk video materi di atas?",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 24),
                      padding: const EdgeInsets.symmetric(horizontal: 9),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                debugPrint(widget.currentFeedback.toString());
                                setFeedback(i);
                              },
                              child: SizedBox(
                                height: 46,
                                width: 46,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: feedback == i
                                        ? Colors.white
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: feedback == i
                                          ? const Color(0xFF725CC8)
                                          : const Color(0xFF696969),
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: feedback == i
                                        ? [
                                            BoxShadow(
                                              color: const Color(0xFF725CC8)
                                                  .withOpacity(0.1),
                                              blurRadius: 5.0,
                                              offset: const Offset(0, 0),
                                              spreadRadius: 3,
                                            )
                                          ]
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      i.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: feedback == i
                                            ? const Color(0xFF725CC8)
                                            : const Color(0xFF696969),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/Flag-Outline.svg",
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Beri masukan",
                                  style: TextStyle(fontSize: 8),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/icon/Warning-Outline.svg",
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "Laporkan masalah",
                                  style: TextStyle(
                                    fontSize: 8,
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Container(
                      width: double.maxFinite,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      child: MainButton(
                          buttonText: buttonText,
                          action: () {
                            if (feedback == 0) {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomAlertDialog(
                                  customIcon: Container(
                                    padding: const EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                      "assets/icon/Warning-Outline.svg",
                                      height: 45,
                                      width: 45,
                                    ),
                                  ),
                                  title: "Kamu Belum Isi Feedback",
                                  desc:
                                      "Isi Feedback terlebih dahulu untuk kualitas yang lebih baik",
                                ),
                              );
                            } else {
                              debugPrint(feedback.toString());
                              if (courseProvider
                                      .getCourseFeedback(widget.index) ==
                                  0) {
                                myCourseStatusProvider.nextQuiz();
                              }
                              debugPrint(myCourseStatusProvider.getselectedQuiz
                                  .toString());
                              courseProvider.updateFeedbackCourse(
                                  widget.index, feedback);

                              Navigator.pop(context);
                            }
                          }),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
