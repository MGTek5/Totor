import 'package:flutter/material.dart';
import 'package:totor/arguments.dart';
import 'package:totor/models/production_company.dart';

class ProductionCard extends StatelessWidget {
  const ProductionCard({Key? key, required this.company, required this.active})
      : super(key: key);

  final ProductionCompany company;
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
        Navigator.pushNamed(context, "/company",
            arguments: CompanyDetailArguments(company.id));
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
              image: NetworkImage(company.getLogo()),
            ),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffEEB868).withOpacity(0.3),
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
                company.name,
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

class ProductionCompanyImageCarousel extends StatefulWidget {
  const ProductionCompanyImageCarousel({Key? key, required this.items})
      : super(key: key);
  final List<ProductionCompany> items;

  @override
  State<ProductionCompanyImageCarousel> createState() =>
      _ProductionCompanyImageCarouselState();
}

class _ProductionCompanyImageCarouselState
    extends State<ProductionCompanyImageCarousel> {
  PageController controller = PageController(viewportFraction: 0.85);
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

  Widget _buildMoviePage(ProductionCompany p, bool active) {
    return ProductionCard(company: p, active: active);
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
