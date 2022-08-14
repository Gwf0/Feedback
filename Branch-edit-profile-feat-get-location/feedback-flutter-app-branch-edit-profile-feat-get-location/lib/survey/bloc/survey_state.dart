part of 'survey_bloc.dart';

abstract class SurveyState extends Equatable {
  const SurveyState();
  
  @override
  List<Object> get props => [];
}

class SurveyInitial extends SurveyState {}
