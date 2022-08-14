import 'package:formz/formz.dart';

enum Pass1ValidationError {
  required('Введите пароль'),
  invalid('Пароль не валидный');

  final String message;
  const Pass1ValidationError(this.message);
}

class Pass1 extends FormzInput<String, Pass1ValidationError> {
  const Pass1.pure([String value = '']) : super.pure(value);
  const Pass1.dirty([String value = '']) : super.dirty(value);

  static final _pass1Regex = RegExp(r"[0-9a-zA-Z]{8}");

  @override
  Pass1ValidationError? validator(String value) {
    return value.isEmpty
        ? Pass1ValidationError.required
        : _pass1Regex.hasMatch(value)
            ? null
            : Pass1ValidationError.invalid;
  }
}
