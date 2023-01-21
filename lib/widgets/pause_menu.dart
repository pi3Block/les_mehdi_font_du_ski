import 'package:flutter/material.dart';
import 'package:les_mehdi_font_du_ski/game_state.dart';
import 'package:les_mehdi_font_du_ski/les_mehdi_font_du_ski.dart';

/// By using the Flutter Widgets we can handle all non-game related UI through
/// widgets.
class PauseMenu extends StatefulWidget {
  /// The reference to the game.
  final LesMehdiFontDuSkiGame game;
  const PauseMenu({Key? key, required this.game}) : super(key: key);

  @override
  _PauseMenuState createState() => _PauseMenuState();
}

class _PauseMenuState extends State<PauseMenu> {
  //late final BannerAd banner;
/*  final listener = BannerAdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      // Dispose the ad here to free resources.
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an impression occurs on the ad.
    onAdImpression: (Ad ad) => print('Ad impression.'),
  );*/

  @override
  void initState() {
    super.initState();
/*    if (!kIsWeb) {
      banner = BannerAd(
        adUnitId: Platform.isIOS
            ? 'ca-app-pub-3940256099942544/2934735716'
            : 'ca-app-pub-3940256099942544/6300978111',
        size: AdSize.banner,
        request: const AdRequest(),
        listener: listener,
      );
      banner.load();
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Text(
                    _getTitle(),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                if (GameState.playState == PlayingState.paused)
                  _getButton(
                    'Resume',
                    () => widget.game.overlays.remove('pause'),
                  ),
                _getButton(
                  'Restart',
                  () {
                    widget.game.overlays.remove('pause');
                    widget.game.restart();
                  },
                ),
                if (GameState.currentLevel != null)
                  _getButton(
                    'Highscorse',
                    () {
                      widget.game.overlays.remove('pause');
                      widget.game.overlays.add('highscore');
                    },
                  ),
                _getButton(
                  'Levels',
                  () {
                    widget.game.overlays.remove('pause');
                    widget.game.overlays.add('levelSelection');
                  },
                ),
                _getButton(
                  'Enter seed',
                  () {
                    widget.game.overlays.remove('');
                    widget.game.overlays.add('enterSeed');
                  },
                ),
                //if (!kIsWeb) _getBannerAd(),
              ],
            ),
          ),
        ),
      ],
    );
  }

/*  Widget _getBannerAd() {
    return Container(
      alignment: Alignment.center,
      width: banner.size.width.toDouble(),
      height: banner.size.height.toDouble(),
      child: AdWidget(ad: banner),
    );
  }*/

  Widget _getButton(
    String label,
    VoidCallback onPressed, {
    bool includeTopMargin = true,
  }) {
    final button = ElevatedButton(
      onPressed: onPressed,
      child: Text(label),
    );
    if (includeTopMargin) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: button,
      );
    }
    return button;
  }

  String _getTitle() {
    if (GameState.playState == PlayingState.paused) {
      return 'Pause';
    } else if (GameState.playState == PlayingState.lost) {
      return 'Ton Mehdi est mort !';
    } else {
      return 'Ton Mehdi à fait un score de : ${GameState.lastScore?.toStringAsFixed(0)}';
    }
  }
}
