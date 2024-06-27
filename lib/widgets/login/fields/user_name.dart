import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/login/other/prefix_icon.dart';

class UserName extends StatelessWidget {
  const UserName({super.key, required this.onNameChange});
  final ValueChanged<String> onNameChange;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        labelText: 'User Name',
        prefixIcon: PrefixIcon(icon: Icons.person_2_rounded),
        prefixIconConstraints: BoxConstraints.tightFor(width: 35),
      ),
      autocorrect: false,
      textCapitalization: TextCapitalization.words,
      validator: (value) {
        if (value == null || value.trim().length < 5 || value.trim().isEmpty) {
          return value == null || value.trim().isEmpty
              ? 'This field can\'t be empty.'
              : 'Name must be atleast 5 characters long';
        }

        return null;
      },
      onChanged: onNameChange,
    );
  }
}
