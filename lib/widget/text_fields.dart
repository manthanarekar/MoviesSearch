import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nicc/api/genres.dart';
import 'package:nicc/colors/colors.dart';

Text HeadText(String input) => Text(
      input.toString(),
      style: GoogleFonts.montserrat(
          textStyle: const TextStyle(
              fontSize: 20,
              color: AppColors.Black,
              fontWeight: FontWeight.w700)),
    );

Text TitleText(String title) {
  String finaltitle = capitalizeEachWord(title);
  return Text(
    finaltitle.toString(),
    style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontSize: 18, color: AppColors.Black, fontWeight: FontWeight.w600)),
  );
}

String capitalizeEachWord(String text) {
  return text.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

Text Ratingtext([double rating = 0]) {
  return Text(
    '${rating.toStringAsFixed(1)} IMDB',
    style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontSize: 13, color: AppColors.White, fontWeight: FontWeight.w500)),
  );
}

Text GenresText(List Genres) {
  int i;
  int j = 0;
  String finalGenres = '';
  for (var data in Genres) {
    for (i = 0; i < GenresList.length; i++) {
      if (data == GenresList[i]['id']) {
        if (j < 3) {
          finalGenres += '${GenresList[i]['name']} | ';
        }
        j++;
      }
    }
  }

  if (finalGenres.endsWith(' | ')) {
    finalGenres = finalGenres.substring(0, finalGenres.length - 3);
  }

  return Text(
    '${finalGenres.toString()}',
    style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
            fontSize: 10, color: AppColors.Black, fontWeight: FontWeight.w500)),
  );
}
