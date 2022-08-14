import 'package:formz/formz.dart';

enum FirstNameValidationError {
  required('Введите имя'),
  invalid('Повторите попытку с корректным именем');

  final String message;
  const FirstNameValidationError(this.message);
}

class FirstName extends FormzInput<String, FirstNameValidationError> {
  const FirstName.pure() : super.pure('');
  const FirstName.dirty([String value = '']) : super.dirty(value);

  static final _firstnameRegex =
      RegExp(r"[а-яА-Яa-zA-Z]+(([',. -][а-яА-Яa-zA-Z])?[а-яА-Яa-zA-Z]*)*$");

  @override
  FirstNameValidationError? validator(String value) {
    return value.isEmpty
        ? FirstNameValidationError.required
        : _firstnameRegex.hasMatch(value)
            ? null
            : FirstNameValidationError.invalid;
  }
}
