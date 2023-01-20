import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

/// Viewport based on the FixedResolutionViewport from Flame.
class FixedVerticalResolutionViewport extends Viewport {
  /// Viewport based on the FixedResolutionViewport from Flame.
  FixedVerticalResolutionViewport(this.effectiveHeight);

  /// The effective height of the viewport.
  final double effectiveHeight;

  final _scaledSize = Vector2.zero();

  /// The scaled size of this viewport.
  Vector2 get scaledSize => _scaledSize.clone();

  final Vector2 _resizeOffset = Vector2.zero();

  /// The offset of this viewport when resized.
  Vector2 get resizeOffset => _resizeOffset.clone();

  late double _scale;

  /// The scale factor.
  double get scale => _scale;

  /// The matrix used for scaling and translating the canvas
  final Matrix4 _transform = Matrix4.identity();

  @override
  void resize(Vector2 newCanvasSize) {
    canvasSize = newCanvasSize.clone();

    _scale = canvasSize!.y / effectiveHeight;

    final preScaleSize = Vector2(
      canvasSize!.x,
      effectiveHeight,
    );

    _scaledSize
      ..setFrom(preScaleSize)
      ..multiply(Vector2(1, _scale));

    _resizeOffset
      ..setFrom(canvasSize!)
      ..sub(_scaledSize)
      ..scale(0.5);

    _transform
      ..setIdentity()
      ..translate(_resizeOffset.x, _resizeOffset.y)
      ..scale(_scale, _scale, 1);
  }

  @override
  void render(Canvas c, void Function(Canvas) renderGame) {
    c.save();
    apply(c);
    renderGame(c);
    c.restore();
  }

  @override
  Vector2 projectVector(Vector2 worldCoordinates) {
    return (worldCoordinates * _scale)..add(_resizeOffset);
  }

  @override
  Vector2 unprojectVector(Vector2 screenCoordinates) {
    return (screenCoordinates - _resizeOffset)..scale(1 / _scale);
  }

  @override
  Vector2 scaleVector(Vector2 worldCoordinates) {
    return worldCoordinates * scale;
  }

  @override
  Vector2 unscaleVector(Vector2 screenCoordinates) {
    return screenCoordinates / scale;
  }

  @override
  Vector2 get effectiveSize => Vector2(canvasSize!.x / _scale, effectiveHeight);

  @override
  void apply(Canvas c) {
    c.transform(_transform.storage);
  }
}
