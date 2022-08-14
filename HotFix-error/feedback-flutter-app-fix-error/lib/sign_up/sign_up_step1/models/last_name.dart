import 'package:formz/formz.dart';

enum LastNameValidationError {
  required('Введите фамилию'),
  invalid('Повторите попытку с корректной фамилией');

  final String message;
  const LastNameValidationError(this.message);
}

class LastName extends FormzInput<String, LastNameValidationError> {
  const LastName.pure() : super.pure('');
  const LastName.dirty([String value = '']) : super.dirty(value);

  static final _lastnameRegex =
      RegExp(r"[а-яА-Яa-zA-Z]+(([',. -][а-яА-Яa-zA-Z])?[а-яА-Яa-zA-Z]*)*$");

  @override
  LastNameValidationError? validator(String value) {
    return value.isEmpty
        ? LastNameValidationError.required
        : _lastnameRegex.hasMatch(value)
            ? null
            : LastNameValidationError.invalid;
  }
}
