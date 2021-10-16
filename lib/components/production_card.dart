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
    final double top = active ? 50 : 70;
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
              fit: BoxFit.scaleDown,
              image: NetworkImage(company.getLogo()),
            ),
            boxShadow: [
              BoxShadow(
                  color: const Color(0xffEEB868).withOpacity(0.3),
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black45,
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
      ),
    );
  }
}