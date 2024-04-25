import 'package:darb_app/utils/colors.dart';
import 'package:darb_app/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.controller, this.hintText, this.onChanged, this.onEditingComplete, this.keyboardType, this.inputFormatters,
  });

  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String value)? onChanged;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      style: const TextStyle(color: blackColor, fontFamily: inukFont, fontSize: 16, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        fillColor: whiteColor,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(fontFamily: inukFont),
        contentPadding: EdgeInsets.zero,
        prefixIcon: const Icon(Icons.search, color: greyColor,),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: signatureYellowColor, width: 2, strokeAlign: BorderSide.strokeAlignInside,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: signatureYellowColor, width: 3, strokeAlign: BorderSide.strokeAlignInside),
        ),
      ),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete
    );
  }
}