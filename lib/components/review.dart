import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:totor/models/rate.dart';

class Review extends StatelessWidget {
  const Review({Key? key, required this.review})
      : super(key: key);

  final Rate review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Card(
        elevation: 500,
        color: Colors.teal,
        child: Column(
          children: [
            RatingBarIndicator(
              rating: review.rate,
              itemCount: 7,
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
            ),
            Text(
              review.comment,
            )
          ],
        )
      ),
    );
  }
}
