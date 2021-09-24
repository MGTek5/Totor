import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:totor/components/movie_card.dart';
import 'package:totor/nav_list.dart';
import 'api.dart';

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
        bottomNavigationBar: SalomonBottomBar(
          items: getNavList(),
          onTap: (index) {
            navigateTo(context: context, index: index);
          },
          currentIndex: getRouteIndex(context: context),
        ),
        body: PageView.builder(
          controller: controller,
          itemCount: _data.length,
          itemBuilder: (context, int currentIdx) {
            if (currentIdx == _data.length - 10) {
              getMovies(page: lastPage + 1);
            }
            bool active = currentIdx == currentPage;
            return _buildMoviePage(_data[currentIdx], active);
          },
        ));
  }
}
