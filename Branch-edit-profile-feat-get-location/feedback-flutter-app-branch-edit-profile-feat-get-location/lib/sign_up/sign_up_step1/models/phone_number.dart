import 'package:formz/formz.dart';

enum PhoneNumberValidationError {
  required('Введите номер телефона'),
  invalid('Введите корректный номер');

  final String message;
  const PhoneNumberValidationError(this.message);
}

class PhoneNumber extends FormzInput<String, PhoneNumberValidationError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([String value = '']) : super.dirty(value);

  static final _phoneRegex = RegExp(r'(^(?:[/+]9)?[0-9]{11,12}$)');

  @override
  PhoneNumberValidationError? validator(String value) {
    return value.isEmpty
        ? PhoneNumberValidationError.required
        : _phoneRegex.hasMatch(value)
            ? null
            : PhoneNumberValidationError.invalid;
  }
}
