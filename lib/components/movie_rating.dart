import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:totor/models/user.dart';
import 'package:totor/utils/totor_api.dart';

import 'button.dart';
import '../models/movie.dart';

class MovieRating extends StatefulWidget {
  const MovieRating(
      {Key? key, required this.m, required this.u, required this.onDone})
      : super(key: key);

  final Movie m;
  final User u;
  final Function onDone;

  @override
  State<MovieRating> createState() => _MovieRatingState();
}

class _MovieRatingState extends State<MovieRating> {
  final TextEditingController _controller = TextEditingController();

  String comment = "";
  double rate = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        padding: const EdgeInsets.all(20),
        color: const Color(0xff303030),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
              TextField(
                  controller: _controller,
                  onChanged: (String v) {
                    setState(() {
                      comment = v;
                    });
                  },
                  keyboardType: TextInputType.multiline,
                  minLines: 6,
                  maxLines: 9,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff292929), width: 2.0),
                    ),
                    hintText:
                        'Feel free to talk, nobody wil judge you.\nYou\'re on the internet.',
                  )),
              RatingBar.builder(
                initialRating: rate,
                minRating: 0.5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 7,
                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (v) {
                  setState(() {
                    rate = v;
                  });
                },
              ),
              Button('Submit', () async {
                bool hasError = false;
                try {
                  await instance.createReview(
                      widget.m.id.toString(), widget.u.id!, rate, comment);
                  widget.onDone();
                  Navigator.pop(context);
                } catch (err) {
                  hasError = true;
                }
                Fluttertoast.showToast(
                    msg: hasError
                        ? "Something went wrong :("
                        : "Review pusblished !",
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor:
                        hasError ? Colors.red : const Color(0xffEEB868),
                    textColor: Colors.white,
                    fontSize: 16.0);
              })
            ])));
  }
}
