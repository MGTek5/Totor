import 'package:flutter/material.dart';
import 'package:totor/arguments.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({Key? key, required this.path, required this.active})
      : super(key: key);

  final String path;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final double blur = active ? 15 : 0;
    final double offset = active ? 7 : 0;
    final double top = active ? 20 : 70;
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/imagefull",
            arguments: ImageFullArguments(path));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(path),
            ),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffEEB868).withOpacity(0.3),
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
      ),
    );
  }
}

class MovieImageCarousel extends StatefulWidget {
  const MovieImageCarousel({Key? key, required this.items}) : super(key: key);
  final List<String> items;

  @override
  State<MovieImageCarousel> createState() => _MovieImageCarouselState();
}

class _MovieImageCarouselState extends State<MovieImageCarousel> {
  PageController controller = PageController(viewportFraction: 0.8);
  int currentPage = 0;

  @override
  initState() {
    super.initState();
    controller.addListener(() {
      int next = controller.page!.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
  }

  Widget _buildMoviePage(String path, bool active) {
    return ImageCard(path: path, active: active);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: controller,
        itemCount: widget.items.length,
        itemBuilder: (ctx, int currentIdx) {
          bool active = currentIdx == currentPage;
          return _buildMoviePage(widget.items[currentIdx], active);
        });
  }
}
