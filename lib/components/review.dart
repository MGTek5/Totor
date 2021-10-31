import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:totor/models/rate.dart';

class Review extends StatelessWidget {
  const Review({Key? key, required Rate review})
      : _review = review,
        super(key: key);

  final Rate _review;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
          elevation: 500,
          color: const Color(0xff303030),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            foregroundImage:
                                NetworkImage(_review.user['profilePic']),
                            radius: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_review.user["username"]),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: _review.rate,
                            itemCount: 7,
                            itemSize: 25,
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _review.comment,
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          )),
    );
  }
}
