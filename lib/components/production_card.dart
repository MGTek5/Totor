import 'package:flutter/material.dart';
import 'package:totor/utils/arguments.dart';
import 'package:totor/models/production_company.dart';

class ProductionCard extends StatelessWidget {
  const ProductionCard(
      {Key? key, required ProductionCompany company, required this.active})
      : _company = company,
        super(key: key);

  final ProductionCompany _company;
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
            arguments: CompanyDetailArguments(_company.id));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.scaleDown,
              image: NetworkImage(_company.getLogo()),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.white12,
                  blurRadius: blur,
                  offset: Offset(offset, offset))
            ]),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  _company.name,
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
