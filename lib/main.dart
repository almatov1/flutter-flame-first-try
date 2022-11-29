import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_231122_gae/dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(
    GameWidget(
      game: JoystickExample(),
      overlayBuilderMap: {
        "DashboardOverlay": (BuildContext context, JoystickExample game) =>
            Dashboard(game: game)
      },
    ),
  );
}

class JoystickExample extends FlameGame
    with HasDraggables, HasCollisionDetection, HasTappables {
  static const String description = '''
    In this example we showcase how to use the joystick by creating simple
    `CircleComponent`s that serve as the joystick's knob and background.
    Steer the player by using the joystick.
  ''';

  late final JoystickPlayer player;
  late final JoystickComponent joystick;
  late Timer timer;
  int point = 0;
  int activePoints = 0;
  late SpriteComponent background;
  bool win = false;
  ShootButton dialogButton = ShootButton();
  Vector2 lastJoystickRelativeDelta = Vector2(0, -1);

  @override
  Future<void> onLoad() async {
    Sprite backgroundSprite = await loadSprite('layers/background.jpg');
    background = SpriteComponent()
      ..sprite = backgroundSprite
      ..size = backgroundSprite.originalSize;
    add(background);

    dialogButton
      ..sprite = await loadSprite('layers/button.png')
      ..positionType = PositionType.viewport
      ..position = Vector2(size.x - 150, size.y - 100)
      ..size = Vector2(75, 50);

    add(dialogButton);

    final knobPaint = BasicPalette.red.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.purple.withAlpha(100).paint();
    joystick = JoystickComponent(
      knob: CircleComponent(radius: 15, paint: knobPaint),
      background: CircleComponent(radius: 50, paint: backgroundPaint),
      margin: const EdgeInsets.only(left: 40, bottom: 40),
    );
    player = JoystickPlayer(joystick, background.size.x, background.size.y);

    add(player);
    add(joystick);

    camera.followComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, background.size.x, background.size.y));

    int counter = 0;
    var rng = Random();

    timer = Timer(
      1,
      repeat: true,
      onTick: () {
        if (counter < 100) {
          add(Enemy(rng.nextDouble() * background.size.x - 200,
              rng.nextDouble() * background.size.y - 200));
          counter++;
          activePoints++;
        } else {
          timer.stop();
        }
      },
    );

    overlays.add('DashboardOverlay');
  }

  @override
  void update(double dt) async {
    super.update(dt);

    timer.update(dt);
  }
}

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

class Enemy extends SpriteComponent
    with HasGameRef<JoystickExample>, CollisionCallbacks {
  final double enemyX;
  final double enemyY;
  Enemy(this.enemyX, this.enemyY);

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('layers/smoke.gif');
    size = Vector2(50, 50);
    position = Vector2(enemyX, enemyY);
    add(RectangleHitbox());

    debugMode = true;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is JoystickPlayer || other is Bullet) {
      FlameAudio.play('pickup.wav');
      gameRef.point++;
      gameRef.activePoints--;
      // ignore: invalid_use_of_internal_member
      gameRef.refreshWidget();
      removeFromParent();

      if (gameRef.point == 100) gameRef.win = true;
    }
  }
}

class ShootButton extends SpriteComponent
    with HasGameRef<JoystickExample>, Tappable {
  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);

    var rng = Random();
    PaletteEntry red = BasicPalette.red;
    PaletteEntry green = BasicPalette.green;
    PaletteEntry blue = BasicPalette.blue;
    PaletteEntry yellow = BasicPalette.yellow;
    PaletteEntry pink = BasicPalette.pink;
    PaletteEntry black = BasicPalette.black;
    PaletteEntry white = BasicPalette.white;
    PaletteEntry purple = BasicPalette.purple;
    PaletteEntry orange = BasicPalette.orange;
    List Colors = [red, green, blue, yellow, pink, black, purple, orange];

    final paint = Colors[rng.nextInt(7)].paint()..style = PaintingStyle.fill;
    Bullet bullet = Bullet(
      gameRef.lastJoystickRelativeDelta,
      position: gameRef.player.position,
      radius: 10.0,
      paint: paint,
    );
    bullet.anchor = Anchor.center;
    gameRef.add(bullet);

    return true;
  }
}

class Bullet extends CircleComponent with HasGameRef<JoystickExample> {
  final double _speed = 450;
  Vector2 direct;
  Bullet(this.direct, {Vector2? position, double? radius, Paint? paint})
      : super(position: position, radius: radius, paint: paint);

  @override
  void onMount() {
    super.onMount();

    final shape = CircleHitbox.relative(
      0.4,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += direct * _speed * dt;

    if (position.x <= 0 ||
        position.y <= 0 ||
        position.x >= gameRef.background.size.x ||
        position.y >= gameRef.background.size.y) {
      removeFromParent();
    }
  }
}
