import 'package:flutter/material.dart';
import 'package:motatool/resources/constants.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.nameController,
    this.focusNode,
    this.name,
    this.nextFocusNode,
    this.onTap,
    this.readOnly,
    this.keyboardType = TextInputType.text,
    this.validate = false,
    this.textColor = Colors.white,
  });

  final TextEditingController? nameController;
  final String? name;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final void Function()? onTap;
  final bool? readOnly;
  final bool? validate;
  final TextInputType? keyboardType;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        controller: nameController,
        focusNode: focusNode,
        onEditingComplete: () {
          FocusScope.of(context).requestFocus(nextFocusNode);
        },
        validator: (validate == true)
            ? (value) {
                if ((value ?? "").isEmpty) {
                  return "This field is required";
                } else {
                  return null;
                }
              }
            : null,
        keyboardType: keyboardType,
        decoration: InputDecoration(
            errorStyle: const TextStyle(color: Colors.red),
            labelText: name,
            border: getOutlineInputBorder(),
            focusedBorder: getOutlineInputBorder(color: textColor),
            errorBorder: getOutlineInputBorder(color: Colors.red),
            focusedErrorBorder: getOutlineInputBorder(color: Colors.red),
            enabledBorder: getOutlineInputBorder(color: textColor),
            disabledBorder: getOutlineInputBorder(color: textColor),
            labelStyle: TextStyle(color: textColor)),
        style: TextStyle(color: textColor),
      ),
    );
  }
}
