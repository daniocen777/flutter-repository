import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final int rating;

  const RatingStars({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String stars = '';
    for (var i = 0; i < rating; i++) {
      stars += '⭐';
    }
    stars.trim();
    return Text(
      stars,
      style: TextStyle(fontSize: 18.0),
    );
  }
}
