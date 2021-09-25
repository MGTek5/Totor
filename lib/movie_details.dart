import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:totor/arguments.dart';
import 'package:totor/components/cast_image_carousel.dart';
import 'package:totor/components/movie_image_carousel.dart';
import 'package:totor/components/production_company_carousel.dart';
import 'package:totor/models/movie.dart';

import 'api.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie? m;
  bool firstTime = true;
  TextStyle sectionTitle =
      const TextStyle(fontSize: 20, fontWeight: FontWeight.w700);

  getDetails(int id) async {
    try {
      Movie tmp = await instance.getMovie(id: id);
      setState(() {
        m = tmp;
        firstTime = false;
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Something went wrong"),
                content: Text("$e"),
              ));
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (firstTime) {
      final MovieDetailsArguments args =
          ModalRoute.of(context)!.settings.arguments as MovieDetailsArguments;
      getDetails(args.id);
    }
  }

  List<Widget> generateProductionCountries() {
    return m!.productionCountries
        .map((e) =>
            SizedBox(height: 100, width: 100, child: Flag.fromString(e.iso)))
        .toList();
  }

  List<Widget> generateGenrePills() {
    List<Widget> tmp = [];

    for (var genre in m!.genres) {
      tmp.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Selected Genre"),
                      content: Text(genre.name),
                    );
                  });
            },
            child: Chip(label: Text(genre.name))),
      ));
    }

    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    if (m == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator(),
              Text("Fetching Movie info, please wait...")
            ],
          ),
        ),
      );
    }
    return (Scaffold(
      body: SafeArea(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(m!.getBackdrop(size: "original")),
                fit: BoxFit.cover)),
        child: Container(
          decoration: const BoxDecoration(color: Color.fromARGB(100, 0, 0, 0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 25),
                    child: Text(
                      m!.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  if (m!.tagline != "")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        m!.tagline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child:
                        Text(m!.overview, style: const TextStyle(fontSize: 18)),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      ...generateGenrePills(),
                    ],
                  ),
                  if (m!.cast.isNotEmpty)
                    Column(
                      children: [
                        Text(
                          "Cast",
                          style: sectionTitle,
                        ),
                        SizedBox(
                          height: 300,
                          child: CastImageCarousel(items: m!.cast),
                        )
                      ],
                    ),
                  if (m!.posters.isNotEmpty)
                    Column(
                      children: [
                        Text(
                          "Posters",
                          style: sectionTitle,
                        ),
                        SizedBox(
                          height: 300,
                          child: MovieImageCarousel(
                              items: m!.posters
                                  .map((e) => m!.getPoster(path: e.filePath))
                                  .toList()),
                        )
                      ],
                    ),
                  if (m!.productionCountries.isNotEmpty)
                    Column(
                      children: [
                        Text(
                          "Produced In",
                          style: sectionTitle,
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          children: [...generateProductionCountries()],
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 12,
                        ),
                      ],
                    ),
                  if (m!.productionCompanies.isNotEmpty)
                    Column(
                      children: [
                        Text("Produced By", style: sectionTitle),
                        SizedBox(
                          height: 300,
                          child: ProductionCompanyImageCarousel(
                              items: m!.productionCompanies),
                        )
                      ],
                    )
                ],
              ),
            ),
          ),
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.star),
      ),
    ));
  }
}
