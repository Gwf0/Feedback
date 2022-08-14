import 'package:formz/formz.dart';

enum CodeValidationError {
  required('Введите код из смс'),
  invalid('Не валидный код');

  final String message;
  const CodeValidationError(this.message);
}

class Code extends FormzInput<String, CodeValidationError> {
  const Code.pure() : super.pure('');
  const Code.dirty([String value = '']) : super.dirty(value);

  static final _codeRegex = RegExp(r"[0-9]{5}");

  @override
  CodeValidationError? validator(String value) {
    return value.isNotEmpty
        ? _codeRegex.hasMatch(value)
            ? null
            : CodeValidationError.invalid
        : CodeValidationError.required;
  }
}
