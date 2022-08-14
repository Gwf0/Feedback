import 'dart:io';

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/quiz_bloc.dart';
import '../data/model/quiz_model.dart';
import '../data/repository/quiz_repository.dart';

class QuizPage extends StatefulWidget {
  @override
  State<QuizPage> createState() => _QuizState();
}

class _QuizState extends State<QuizPage> {
  final QuizRepository quizRepository = new QuizRepository();
  Widget build(BuildContext context) {
    return BlocProvider<QuizBloc>(
        create: (context) => QuizBloc(
              quizRepository: quizRepository,
            )..add(QuizFetchEvent()),
        child: BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
          if (state is QuizLoading) {
            return Container(
                color: Colors.white,
                child: const Center(
                  child: CircularProgressIndicator(),
                ));
          }
          if (state is QuizError) {
            return Container(
                color: Colors.white, child: Center(child: Text(state.message)));
          }
          if (state is QuizLoaded) {
            return SafeArea(
                child: Scaffold(
                    appBar: AppBar(
                      title: const Text('Отчет'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop('Questions Agreed');
                            },
                            child: new Text('Заполнил',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(color: Colors.white))),
                      ],
                    ),
                    body: SizedBox(
                        height: 10000,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: <
                                Widget>[
                          Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.quizItem.result.length,
                                  addSemanticIndexes: true,
                                  addRepaintBoundaries: true,
                                  addAutomaticKeepAlives: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 10,
                                                    left: 10,
                                                    right: 10,
                                                  ),
                                                  child: ListTile(
                                                    title: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 10.0),
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Text(state
                                                              .quizItem
                                                              .result
                                                              .first
                                                              .titles
                                                              .first),
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.5,
                                                                  color: Colors
                                                                      .grey),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          10))),
                                                        )),
                                                  ))),
                                          ListView.builder(
                                            itemCount:
                                                state.quizItem.result.length,
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _builQuizItem(
                                                quiz: state
                                                    .quizItem.result[index],
                                                context: context,
                                              );
                                            },
                                          ),
                                          ListView.builder(
                                            itemCount: 1,
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _buildQuizInputItem(
                                                quiz: state
                                                    .quizItem.result[index],
                                                context: context,
                                              );
                                            },
                                          ),
                                          ListView.builder(
                                            itemCount: 1,
                                            physics: ClampingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return _buildQuizInputItemPhoto(
                                                quiz: state
                                                    .quizItem.result[index],
                                                context: context,
                                              );
                                            },
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.65,
                                                      child: ElevatedButton(
                                                        style: ButtonStyle(
                                                            shape: MaterialStateProperty.all<
                                                                    RoundedRectangleBorder>(
                                                                RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      30.0),
                                                        ))),
                                                        onPressed: () {},
                                                        child: const Text(
                                                            'Отправить'),
                                                      )))
                                            ],
                                          ),
                                        ]);
                                  }))
                        ]))));
          }
          return Container();
        }));
  }

  List<bool> isSelected = List.generate(3, (_) => false);

  Widget _builQuizItem({required Result quiz, required BuildContext context}) {
    return Container(
        alignment: Alignment.center,
        child: Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Text(quiz.title.characters.string),
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.5, color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                  )),
              subtitle: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Row(
                  children: [
                    ToggleButtons(
                      constraints: BoxConstraints.expand(width: 75, height: 50),
                      borderRadius: BorderRadius.circular(10),
                      renderBorder: false,
                      children: <Widget>[
                        Text(quiz.item.control.options.first.label),
                        Text('Не везде'),
                        Text(quiz.item.control.options.last.label),
                      ],
                      onPressed: (int index) {
                        int count = 0;
                        isSelected.forEach((bool val) {
                          if (val) count++;
                        });

                        if (isSelected[index] && count < 2) return;

                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });
                      },
                      isSelected: isSelected,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
              leading: Container(
                decoration: BoxDecoration(
                  border: Border(),
                ),
                child: Icon(
                  Icons.quiz_outlined,
                  color: Colors.red,
                ),
              ),
            )));
  }

  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Не удалось выбрать изображение: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Не удалось выбрать изображение: $e');
    }
  }

  final TextEditingController controller = TextEditingController();
  final maxLength = 100;

  @override
  void initState() {
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  Widget _buildQuizInputItem(
      {required Result quiz, required BuildContext context}) {
    return Container(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 10,
              top: 0,
            ),
            child: ListTile(
              title: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 5,
                      right: 0,
                      top: 2,
                    ),
                    child: TextFormField(
                      maxLength: 100,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        icon: Icon(Icons.send),
                        hintText: quiz.artifacts.toString(),
                        helperText: 'Максимальное количество символов',
                        counterText: "${controller.text}$maxLength",
                        suffixIcon: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  pickImage();
                                },
                                icon: const Icon(Icons.photo),
                              ),
                              IconButton(
                                  onPressed: () {
                                    pickImageC();
                                  },
                                  icon: const Icon(Icons.photo_camera)),
                            ]),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                      ),
                      maxLines: 8,
                      minLines: 1,
                    ),
                  )),
            )));
  }

  Widget _buildQuizInputItemPhoto(
      {required Result quiz, required BuildContext context}) {
    return Container(
        alignment: Alignment.center,
        child: Padding(
            padding: const EdgeInsets.only(
              left: 6,
              right: 10,
            ),
            child: ListTile(
              title: Container(
                padding: EdgeInsets.all(10),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  image != null
                      ? Image.file(image!)
                      : Text("Изображение не выбрано")
                ]),
                decoration: BoxDecoration(
                    border: Border.all(width: 0.5, color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
              ),
            )));
  }
}
