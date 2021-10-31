import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:totor/models/genre.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/components/carousel.dart';
import 'package:totor/components/cast_card.dart';
import 'package:totor/components/movie_image_card.dart';
import 'package:totor/components/movie_part.dart';
import 'package:totor/components/production_card.dart';
import 'package:totor/components/movie_rating.dart';
import 'package:totor/components/review.dart';
import 'package:totor/models/movie.dart';
import 'package:totor/models/user.dart';
import 'package:totor/utils/custom_colors.dart';
import 'package:totor/utils/totor_api.dart' as totor_api;
import 'package:totor/components/movie_details_backdrop.dart';
import 'package:totor/models/rate.dart';
import 'package:totor/utils/tmdb.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({Key? key}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<Rate>? _rates = [];
  Movie? _m;
  bool _firstTime = true;

  _getDetails(int id) async {
    try {
      Movie tmp = await instance.getMovie(id: id);
      setState(() {
        _m = tmp;
        _firstTime = false;
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

  _getRates(int id) async {
    try {
      List<Rate> tmp = await totor_api.instance.getReviews(id.toString());
      setState(() {
        _rates = tmp;
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title:
                    const Text("Something went wrong while retrieving reviews"),
                content: Text("$e"),
              ));
      _rates = [];
    }
  }

  List<Widget> _generateProductionCountries() {
    return _m!.productionCountries
        .map((e) =>
            SizedBox(height: 100, width: 100, child: Flag.fromString(e.iso)))
        .toList();
  }

  List<Widget> _generateGenrePills() {
    List<Widget> tmp = [];

    for (Genre genre in _m!.genres) {
      tmp.add(Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/movie/genre",
                  arguments: GenreDiscoveryArguments(genre));
            },
            child: Chip(
              label: Text(genre.name),
              backgroundColor: genre.getColor(),
            )),
      ));
    }

    return tmp;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstTime) {
      final MovieDetailsArguments args =
          ModalRoute.of(context)!.settings.arguments as MovieDetailsArguments;
      _getRates(args.id);
      _getDetails(args.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if (_m == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CircularProgressIndicator.adaptive(),
              Text("Fetching Movie info, please wait...")
            ],
          ),
        ),
      );
    }
    return (Scaffold(
      body: SafeArea(
        child: MovieDetailsBackdrop(
          backdrop: _m!.getBackdrop(size: "w780"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5.0, top: 25),
                    child: Text(
                      _m!.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                  ),
                  if (_m!.tagline != "")
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        _m!.tagline,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: ReadMoreText(_m!.overview,
                        style: const TextStyle(fontSize: 18)),
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: [
                      ..._generateGenrePills(),
                    ],
                  ),
                  if (_m!.cast.isNotEmpty)
                    MoviePart(children: [
                      SizedBox(
                        height: 300,
                        child: Carousel(
                            itemCount: _m!.cast.length,
                            buildItem:
                                (BuildContext ctx, int idx, bool active) {
                              return CastCard(
                                  cast: _m!.cast[idx], active: active);
                            }),
                      )
                    ], title: "Cast"),
                  if (_m!.posters.isNotEmpty)
                    MoviePart(
                      title: "Posters",
                      children: [
                        SizedBox(
                          height: 300,
                          child: Carousel(
                              itemCount: _m!.posters.length,
                              buildItem:
                                  (BuildContext ctx, int idx, bool active) {
                                return ImageCard(
                                    path: _m!.getPoster(
                                        path: _m!.posters[idx].filePath),
                                    active: active);
                              }),
                        )
                      ],
                    ),
                  if (_m!.productionCountries.isNotEmpty)
                    MoviePart(
                      title: "Produced In",
                      children: [
                        Wrap(
                          direction: Axis.horizontal,
                          children: [..._generateProductionCountries()],
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 12,
                        ),
                      ],
                    ),
                  if (_m!.productionCompanies.isNotEmpty)
                    MoviePart(
                      title: "Produced By",
                      children: [
                        SizedBox(
                          height: 300,
                          child: Carousel(
                            vFraction: 0.85,
                            itemCount: _m!.productionCompanies.length,
                            buildItem:
                                (BuildContext ctx, int idx, bool active) {
                              return ProductionCard(
                                  company: _m!.productionCompanies[idx],
                                  active: active);
                            },
                          ),
                        ),
                      ],
                    ),
                  if (_rates!.isNotEmpty)
                    MoviePart(title: "Reviews", children: [
                      ..._rates!.map((e) => Review(review: e)).toList()
                    ]),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: user.logged
          ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return MovieRating(
                          m: _m!,
                          u: user,
                          onDone: () {
                            _getRates(_m!.id);
                          });
                    });
              },
              child: Icon(Icons.star, color: totorGrey),
              backgroundColor: totorYellow)
          : null,
    ));
  }
}
