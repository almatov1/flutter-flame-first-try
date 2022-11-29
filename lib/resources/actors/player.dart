import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter_231122_gae/resources/game.dart';

class JoystickPlayer extends SpriteAnimationComponent
    with HasGameRef<JoystickExample>, CollisionCallbacks {
  /// Pixels/s
  double maxSpeed = 300.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();
  final JoystickComponent joystick;
  final double backgroundX;
  final double backgroundY;

  late SpriteComponent playerSprite;
  late SpriteAnimationComponent player;

  JoystickPlayer(this.joystick, this.backgroundX, this.backgroundY)
      : super(size: Vector2.all(50.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    var runData = SpriteAnimationData.sequenced(
        amount: 4, stepTime: 0.1, textureSize: Vector2(48, 48));
    var runImage = await Flame.images.load('layers/plane.png');
    animation = SpriteAnimation.fromFrameData(runImage, runData);
    // sprite = await gameRef.loadSprite('layers/player.png');
    position = gameRef.size / 2;
    add(RectangleHitbox());
  }

  @override
  void update(double dt) async {
    super.update(dt);
    if (position.x <= 0) position.x = 1;
    if (position.y <= 0) position.y = 1;
    if (position.x >= backgroundX) position.x = backgroundX - 1;
    if (position.y >= backgroundY) position.y = backgroundY - 1;

    if (position.x > 0 &&
        position.y > 0 &&
        position.y < backgroundY &&
        position.x < backgroundX) {
      if (!joystick.delta.isZero() && activeCollisions.isEmpty) {
        _lastSize.setFrom(size);
        _lastTransform.setFrom(transform);
        position.add(joystick.relativeDelta * maxSpeed * dt);
        angle = joystick.delta.screenAngle();

        gameRef.lastJoystickRelativeDelta = joystick.relativeDelta;
      }
    }
  }
}
