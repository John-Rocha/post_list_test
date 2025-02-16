import 'package:formz/formz.dart';

enum BodyValidationError { empty }

class Body extends FormzInput<String, BodyValidationError> {
  const Body.pure() : super.pure('');
  const Body.dirty([super.value = '']) : super.dirty();

  @override
  BodyValidationError? validator(String? value) {
    return value?.isNotEmpty == true ? null : BodyValidationError.empty;
  }
}
