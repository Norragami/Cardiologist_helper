import 'package:reactive_forms/reactive_forms.dart';

class RequiredCustomValidator extends Validator<dynamic> {
  const RequiredCustomValidator() : super();
  @override
  Map<String, dynamic>? validate(AbstractControl<dynamic> control) {
    return control.value != null && control.value.toString().isNotEmpty
        ? null
        : {'Это обязательное поле': 'This field is required'};
  }
}
