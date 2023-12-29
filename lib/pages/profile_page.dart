import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double circleRadius = 175.0;
  final double circleBorderWidth = 8.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: circleRadius / 2.0),
          child: const Card(
            child: SizedBox(
              width: 300,
              height: 550,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 120.0),
                  child: Column(
                    children: [
                      Text("Username goes Here"),
                      Text("Email goes Here"),
                      Text("Favorite tags Here"),
                      Card(
                        color: Color.fromRGBO(20, 17, 33, 100),
                        child: SizedBox(
                          height: 100,
                          width: 200,
                        ),
                      ),
                      Text("Stats"),
                      Card(
                        color: Color.fromRGBO(20, 17, 33, 100),
                        child: SizedBox(
                          height: 100,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: circleRadius,
          height: circleRadius,
          decoration:
              const ShapeDecoration(shape: CircleBorder(), color: Colors.white),
          child: Padding(
            padding: EdgeInsets.all(circleBorderWidth),
            child: const DecoratedBox(
              decoration: ShapeDecoration(
                  shape: CircleBorder(),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://avatars.githubusercontent.com/u/81005238?v=4',
                      ))),
            ),
          ),
        ),
      ],
    );
  }
}
