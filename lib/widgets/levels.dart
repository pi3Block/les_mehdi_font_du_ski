import 'package:flutter/material.dart';
import '/database/database.dart';
import '/game_state.dart';

import '../les_mehdi_font_du_ski.dart';

/// Show a level selection screen as a grid with fixed amount of columns.
class LevelSelection extends StatefulWidget {
  /// Show a level selection screen as a grid with fixed amount of columns.
  const LevelSelection(this.game, {Key? key}) : super(key: key);

  /// Reference to the game.
  final LesMehdiFontDuSkiGame game;

  @override
  _LevelSelectionState createState() => _LevelSelectionState();
}

class _LevelSelectionState extends State<LevelSelection> {
  List<LevelData>? levels;

  @override
  void initState() {
    super.initState();
    GameState.database.getAllLevels().then(
          (value) => setState(
            () => levels = value,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Material(
            child: Container(
              width: 320,
              height: 320,
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 15,
                    ),
                    child: Text(
                      'Level selection',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  _buildLevelList(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLevelList() {
    if (levels == null) {
      return const CircularProgressIndicator();
    }
    return Expanded(
      child: GridView.count(
        crossAxisCount: 4,
        children: levels!
            .map(
              (e) => TextButton(
                onPressed: () {
                  GameState.currentLevel = e;
                  widget.game.loadLevel(e.seed);
                },
                child: Text(
                  e.id.toString(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: e.highscore == null ? Colors.black : Colors.green,
                      ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
