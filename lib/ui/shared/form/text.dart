import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField(
      {Key? key,
      required this.labelText,
      required this.initialValue,
      required this.existingNames,
      required this.onSavedName,
      this.validator})
      : super(key: key);

  final String labelText;
  final String initialValue;
  final List<String> existingNames;
  final ValueChanged<String> onSavedName;
  final String? Function(String?)? validator;

  _saveName(String? name) {
    if (name != null) {
      onSavedName(name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(),
          ),
          labelText: labelText),
      initialValue: initialValue,
      keyboardType: TextInputType.text,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return 'Name can\'t be empty';
            }
            if (existingNames.contains(value)) {
              return 'Name already exists';
            }
            return null;
          },
      onSaved: (value) => _saveName(value),
    );
  }
}
