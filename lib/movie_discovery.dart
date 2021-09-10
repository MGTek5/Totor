import 'package:flutter/material.dart';

import 'api.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({Key? key, required this.m, required this.active})
      : super(key: key);

  final Movie m;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 30 : 0;
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/movie/details", arguments: {"id": m.id});
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(m.getPoster()),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black87,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
      ),
    );
  }
}

class MovieDiscovery extends StatefulWidget {
  const MovieDiscovery({Key? key}) : super(key: key);

  @override
  _MovieDiscoveryState createState() => _MovieDiscoveryState();
}

class _MovieDiscoveryState extends State<MovieDiscovery> {
  List<Movie> _data = [];
  PageController controller = PageController(viewportFraction: 0.95);
  int currentPage = 0;
  int lastPage = 1;
  void getMovies({int page = 1}) async {
    List<Movie> data = await instance.getTrendingMovies(page: page);
    setState(() {
      _data = _data + data;
      lastPage = page;
    });
  }

  @override
  initState() {
    super.initState();
    getMovies();
    controller.addListener(() {
      int next = controller.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  Widget _buildMoviePage(Movie m, bool active) {
    return MovieCard(m: m, active: active);
  }

  @override
  Widget build(BuildContext context) {
    if (_data.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
        body: PageView.builder(
      controller: controller,
      itemCount: _data.length,
      itemBuilder: (context, int currentIdx) {
        // Active page
        if (currentIdx == _data.length - 10) {
          getMovies(page: lastPage + 1);
        }
        bool active = currentIdx == currentPage;
        return _buildMoviePage(_data[currentIdx], active);
      },
    ));
  }
}
