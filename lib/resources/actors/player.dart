import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter_231122_gae/resources/screens/game.dart';

class MainPlayer extends PositionComponent
    with HasGameRef<Online2DGame>, CollisionCallbacks {
  double maxSpeed = 300.0;
  late final Vector2 _lastSize = size.clone();
  late final Transform2D _lastTransform = transform.clone();
  final JoystickComponent joystick;
  final double backgroundX;
  final double backgroundY;

  late SpriteComponent playerSprite;
  late SpriteAnimationComponent player;

  MainPlayer(this.joystick, this.backgroundX, this.backgroundY)
      : super(size: Vector2.all(50.0), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    position = Vector2(0, 0);
    anchor = Anchor.center;
    add(RectangleHitbox());

    debugMode = true;
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
        position.add(joystick.relativeDelta * dt * maxSpeed);
        angle = joystick.delta.screenAngle();

        gameRef.socket.emit('updatePosition', [position.x, position.y]);
      }
    }
  }
}
