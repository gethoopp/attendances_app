/// Used in BlocSelector
class FormFieldData<T> {
  final List validate;
  final List validateForm;

  final T? value;
  final String? key;

  FormFieldData({
    this.validate = const [],
    this.validateForm = const [],
    this.value,
    this.key,
  });

  bool get hasEmptyField => validate.any((element) {
        bool validation = element == null;
        if (element is List || element is Map) {
          validation = validation || element.isEmpty;
        }
        if (element is String) {
          validation = validation || element.trim().isEmpty;
        }

        if (element is bool) {
          validation = element == false;
        }
        return validation;
      });

  bool get hasInvalidField => validateForm.any((element) {
        bool validation = element != null;

        if (element is bool) {
          validation = element == false;
        }

        return validation;
      });
}
