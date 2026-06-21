import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class CustomTextField extends StatefulWidget {
final String hintText;
final IconData icon;
final bool obscureText;
final TextEditingController? controller;

const CustomTextField({
  super.key,
  required this.hintText,
  required this.icon,
  this.obscureText = false,
  this.controller,
});
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hiddenPassword;

  @override
  void initState() {
    super.initState();
    hiddenPassword = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
return TextField(
  controller: widget.controller,
  obscureText: hiddenPassword,
  decoration: InputDecoration(        
    hintText: widget.hintText,

        prefixIcon: Icon(
          widget.icon,
          color: AppTheme.primary,
        ),

        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  hiddenPassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppTheme.lightText,
                ),
                onPressed: () {
                  setState(() {
                    hiddenPassword = !hiddenPassword;
                  });
                },
              )
            : null,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 20,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppTheme.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}