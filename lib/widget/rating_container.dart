import 'package:flutter/material.dart';
import 'package:nicc/widget/text_fields.dart';

Widget RatingContainer(Color backcolor, double rating) {
  return Container(
    height: 25,
    width: 90,
    decoration: BoxDecoration(
      color: backcolor,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(child: Ratingtext(rating)),
  );
}
