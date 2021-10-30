import 'package:flutter/material.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/models/person.dart';

class CastCard extends StatelessWidget {
  const CastCard({Key? key, required this.cast, required this.active})
      : super(key: key);

  final Cast cast;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 15 : 0;
    final double offset = active ? 7 : 0;
    final double top = active ? 20 : 70;
    TextStyle titleStile =
        const TextStyle(fontSize: 20, fontWeight: FontWeight.w600);
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/cast/details",
            arguments: CastDetailArguments(cast.id));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.darken),
              image: NetworkImage(cast.getProfilePic()),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                cast.name,
                style: titleStile,
                textAlign: TextAlign.center,
              ),
              const Text("as"),
              Text(
                cast.character ?? "Anon",
                style: titleStile,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
