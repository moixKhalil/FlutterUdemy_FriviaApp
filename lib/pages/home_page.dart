import 'package:flutter/material.dart';
import 'package:frivia_app/pages/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  double? _currentlyDifficultyLevel = 0;
  final List<String> _difficulText = ["Easy", "Medium", "Hard"];
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              _appTitle(),
              _difficultySlider(),
              _startGameButton(),
            ],
          ),
        ),
      )),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        Text(
          "Frivia",
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          _difficulText[_currentlyDifficultyLevel!.toInt()],
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }

  Widget _difficultySlider() {
    return Slider(
        label: "difficulty",
        min: 0,
        max: 2,
        divisions: 2,
        value: _currentlyDifficultyLevel!.toDouble(),
        onChanged: (_value) {
          setState(() {
            _currentlyDifficultyLevel = _value;
          });
        });
  }

  Widget _startGameButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext _context) {
          return GamePage(
            difficultyLevel:
                _difficulText[_currentlyDifficultyLevel!.toInt()].toLowerCase(),
          );
        }));
      },
      color: Colors.blue,
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      child: Text(
        "Start",
        style: TextStyle(color: Colors.white, fontSize: 25),
      ),
    );
  }
}
