import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/models/person.dart';
import 'package:totor/utils/tmdb.dart';

class CastDetails extends StatefulWidget {
  const CastDetails({Key? key}) : super(key: key);

  @override
  _CastDetailsState createState() => _CastDetailsState();
}

class _CastDetailsState extends State<CastDetails> {
  bool firstTime = true;
  late Person person;

  getDetails(int id) async {
    Person tmp = await instance.getPerson(id: id);
    setState(() {
      firstTime = false;
      person = tmp;
    });
  }

  @override
  void didChangeDependencies() {
    if (firstTime) {
      final CastDetailArguments args =
          ModalRoute.of(context)!.settings.arguments as CastDetailArguments;
      getDetails(args.id);
    }
    super.didChangeDependencies();
  }

  TextStyle sectionTitle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    if (firstTime) {
      return const Scaffold(
        body: SafeArea(
            child: Center(
          child: CircularProgressIndicator.adaptive(),
        )),
      );
    }

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                person.name,
                style: sectionTitle,
                textAlign: TextAlign.center,
              ),
              Image.network(
                person.getProfilePic(),
                width: MediaQuery.of(context).size.width / 2,
              ),
              if (person.biography!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ReadMoreText(person.biography ?? ""),
                ),
              if (person.movieCredits.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(
                        "Seen in",
                        style: sectionTitle,
                      ),
                      SizedBox(
                          height: 500,
                          child: Carousel(
                              buildItem: (context, int idx, bool active) {
                                return MovieCard(
                                    activeTop: 50,
                                    inactiveTop: 125,
                                    movie: person.movieCredits[idx],
                                    active: active);
                              },
                              vFraction: 0.85,
                              itemCount: person.movieCredits.length))
                    ],
                  ),
                )
            ],
          ),
        ),
      )),
    );
  }
}
