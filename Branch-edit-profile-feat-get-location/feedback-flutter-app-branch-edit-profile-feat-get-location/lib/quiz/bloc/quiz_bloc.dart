import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feedback24_app/quiz/data/model/quiz_model.dart';

import '../data/repository/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  QuizBloc({required this.quizRepository}) : super(QuizInitial()) {
    on<QuizFetchEvent>(_fetchQuiz);
  }

  FutureOr<void> _fetchQuiz(
      QuizFetchEvent event, Emitter<QuizState> emit) async {
    try {
      emit(QuizLoading());
      final quizItem = await quizRepository.quiz('5643');
      emit(QuizLoaded(quizItem: quizItem));
    } catch (e) {
      emit(QuizError(message: e.toString()));
    }
  }
}
