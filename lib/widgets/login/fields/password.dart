import 'package:flutter/material.dart';

import 'package:sohna_salon_app/widgets/login/other/prefix_icon.dart';

class Password extends StatefulWidget {
  const Password({super.key, required this.onNameChange});
  final ValueChanged<String> onNameChange;

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password',
          prefixIcon: const PrefixIcon(icon: Icons.lock_rounded),
          prefixIconConstraints: const BoxConstraints.tightFor(width: 35),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              icon: Icon(
                _obscureText ? Icons.visibility : Icons.visibility_off,
              ))),
      autocorrect: false,
      obscureText: _obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty || value.trim().length < 6) {
          return value == null || value.trim().isEmpty
              ? 'This field can\'t be empty.'
              : 'Password must be atleast 6 characters long';
        }
        return null;
      },
      onChanged: widget.onNameChange,
    );
  }
}
