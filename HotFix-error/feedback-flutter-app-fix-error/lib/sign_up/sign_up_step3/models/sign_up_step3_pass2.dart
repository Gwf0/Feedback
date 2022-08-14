import 'package:formz/formz.dart';

enum Pass2ValidationError {
  required('Повторите пароль'),
  invalid('Пароли не совпадают');

  final String message;
  const Pass2ValidationError(this.message);
}

class Pass2 extends FormzInput<String, Pass2ValidationError> {
  const Pass2.pure([String value = '']) : super.pure(value);
  const Pass2.dirty([String value = '']) : super.dirty(value);

  static final _pass2Regex = RegExp(r"[0-9a-zA-Z]{8}");

  @override
  Pass2ValidationError? validator(String value) {
    return value.isEmpty
        ? Pass2ValidationError.required
        : _pass2Regex.hasMatch(value)
            ? null
            : Pass2ValidationError.invalid;
  }
}
