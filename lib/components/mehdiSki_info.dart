import '/components/mehdi_ski_joystick_player.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

/// Draw the stats of our rocket.
class MehdiSkiInfo extends PositionComponent with HasGameRef {
  /// Create new rocket info instance.
  MehdiSkiInfo(this._mehdi) : super();

  final _textRenderer = TextPaint(
    style: const TextStyle(
      fontSize: 20,
      fontFamily: 'AldotheApache',
      color: Colors.white,
    ),
  );

  var _text = '';

  final MehdiSkiJoystickPlayer _mehdi;

  String _guiNumber(double number) => number.toStringAsFixed(2);

  @override
  Future<void>? onLoad() async {
    _text = 'Fuel: 100 % \n'
        'Vertical speed: -99.00\n'
        'Horizontal speed: -99.00';
    final textSize = _textRenderer.measureText(_text);
    size = textSize;
    position = Vector2(gameRef.size.x / 2 - size.x / 2, textSize.y / 3);
    positionType = PositionType.viewport;
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final actualSpeed = _mehdi.velocity.scaled(_mehdi.speed.toDouble());
    _text = '''
            Fuel: ${_guiNumber(_mehdi.fuel)} %
            Horizontal speed: ${_guiNumber(actualSpeed.x)}
            Vertical speed: ${_guiNumber(actualSpeed.y * -1)}
            ''';
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    final pos = Vector2.zero();
    _text.split('\n').forEach((line) {
      _textRenderer.render(canvas, line, pos);
      pos.y += size.y / 3;
    });

    super.render(canvas);
  }
}
