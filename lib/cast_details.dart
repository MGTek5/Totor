import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:totor/arguments.dart';
import 'package:totor/models/person.dart';
import 'package:totor/tmdb.dart';

class CastDetails extends StatefulWidget {
  const CastDetails({Key? key}) : super(key: key);

  @override
  _CastDetailsState createState() => _CastDetailsState();
}

class _CastDetailsState extends State<CastDetails> {
  bool firstTime = true;
  late Person person;

  getDetails(int id) async {
    var tmp = await instance.getPerson(id: id);
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
          child: CircularProgressIndicator(),
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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ExpandablePanel(
                  header: const Text("Biography"),
                  expanded: Text(person.biography ?? "No bio"),
                  collapsed: Text(
                    person.biography ?? "No bio",
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  theme: const ExpandableThemeData(iconColor: Colors.white),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
