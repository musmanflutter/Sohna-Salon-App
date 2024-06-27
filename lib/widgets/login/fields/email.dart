import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/login/other/prefix_icon.dart';

class Email extends StatelessWidget {
  const Email({super.key, required this.onNameChange});
  final ValueChanged<String> onNameChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: PrefixIcon(icon: Icons.email_rounded),
        prefixIconConstraints: BoxConstraints.tightFor(width: 35),
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textCapitalization: TextCapitalization.none,
      validator: (value) {
        if (value == null ||
            value.trim().isEmpty ||
            !value.contains('@') ||
            !value.contains('.com')) {
          return value == null || value.trim().isEmpty
              ? 'This field can\'t be empty.'
              : !value.contains('@')
                  ? 'Email must contain @ sign.'
                  : !value.contains('.com')
                      ? 'email must contain .com.'
                      : 'Please enter a valid email adress.';
        }
        return null;
      },
      onChanged: onNameChange,
    );
  }
}
