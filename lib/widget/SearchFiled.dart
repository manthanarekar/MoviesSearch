import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nicc/colors/colors.dart';

TextField Search_Field(var Controller) {
  return TextField(
    controller: Controller,
    decoration: InputDecoration(
      labelText: 'Search',
      labelStyle: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              color: AppColors.Blue2, fontWeight: FontWeight.w500)),
      suffixIcon: const Icon(Icons.search_rounded, size: 25),
      suffixIconColor: AppColors.Blue2,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: AppColors.Blue2,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: AppColors.Blue2,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(3),
        borderSide: const BorderSide(
          color: AppColors.Blue2,
          width: 1.5,
        ),
      ),
    ),
  );
}
