import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const SmileyApp());
}

class SmileyApp extends StatelessWidget {
  const SmileyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Selector',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SmileyScreen(),
    );
  }
}

class SmileyScreen extends StatefulWidget {
  const SmileyScreen({super.key});

  @override
  State<SmileyScreen> createState() => _SmileyScreenState();
}

class _SmileyScreenState extends State<SmileyScreen> {
  String? selectedEmoji;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji Selector'),
        backgroundColor: Colors.amber.shade100,
      ),
      body: Column(
        children: [
          // Dropdown menu container
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 231, 254, 255),
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Select an Emoji:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 213, 255),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 20),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    hint: const Text(
                      'Choose an emoji...',
                      style: TextStyle(color: Colors.grey),
                    ),
                    value: selectedEmoji,
                    underline: Container(),
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.orange),
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'smiley',
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text('Big Bright Smile'),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'heart',
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text('Simple Heart'),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'party',
                        child: Row(
                          children: [
                            SizedBox(width: 10),
                            Text('Party Face'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedEmoji = newValue;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          
          // Main drawing area
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.0,
                  colors: [
                    Colors.yellow.shade100,
                    Colors.orange.shade50,
                  ],
                ),
              ),
              child: selectedEmoji == null
                  ? const Center(
                      child: Text(
                        'Select an emoji from the dropdown above!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : CustomPaint(
                      painter: SmileyFacePainter(selectedEmoji!),
                      size: Size.infinite,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class SmileyFacePainter extends CustomPainter {
  final String emojiType;
  
  SmileyFacePainter(this.emojiType);

  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    if (emojiType == 'smiley') {
      _drawSmileyFace(canvas, size, centerX, centerY);
    } else if (emojiType == 'heart') {
      _drawHeart(canvas, size, centerX, centerY);
    } else if (emojiType == 'party') {
      _drawPartyFace(canvas, size, centerX, centerY);
    }
  }
  
  void _drawSmileyFace(Canvas canvas, Size size, double centerX, double centerY) {
    final faceRadius = min(size.width, size.height) * 0.2;
    
    // Draw the face (simple yellow circle)
    final facePaint = Paint()
      ..color = const Color(0xFFFDBF17)
      ..style = PaintingStyle.fill;
    
    canvas.drawCircle(
      Offset(centerX, centerY), 
      faceRadius, 
      facePaint,
    );
    
    // Calculate eye positions and size
    final eyeWidth = faceRadius * 0.25;
    final eyeHeight = faceRadius * 0.45;
    final eyeOffsetX = faceRadius * 0.35;
    final eyeOffsetY = faceRadius * 0.25;
    
    // Fill the left eye (black oval)
    final leftEyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX - eyeOffsetX, centerY - eyeOffsetY),
        width: eyeWidth,
        height: eyeHeight,
      ),
      leftEyePaint,
    );
    
    // Fill the right eye (black oval)
    final rightEyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX + eyeOffsetX, centerY - eyeOffsetY),
        width: eyeWidth,
        height: eyeHeight,
      ),
      rightEyePaint,
    );
    
    // Draw the smile (black arc)
    final smileRadius = faceRadius * 0.60;
    final smileOffsetY = faceRadius * 0.10;
    
    final smilePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = faceRadius * 0.06
      ..strokeCap = StrokeCap.round;
    
    final smileRect = Rect.fromCenter(
      center: Offset(centerX, centerY + smileOffsetY),
      width: smileRadius * 2,
      height: smileRadius * 2,
    );
    
    canvas.drawArc(
      smileRect,
      0.3, // Start angle
      2.5, // Sweep angle
      false,
      smilePaint,
    );
  }
  
  void _drawHeart(Canvas canvas, Size size, double centerX, double centerY) {
    final heartSize = min(size.width, size.height) * 0.25;

    final heartPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final path = Path();

    // Start at bottom point
    path.moveTo(centerX, centerY + heartSize);

    // Left curve
    path.cubicTo(
      centerX - heartSize * 1, centerY + heartSize * 0.5,
      centerX - heartSize * 1, centerY - heartSize,
      centerX, centerY - heartSize * 0.1,
    );

    // Right curve (mirror of left)
    path.cubicTo(
      centerX + heartSize * 1, centerY - heartSize,
      centerX + heartSize * 1, centerY + heartSize * 0.5,
      centerX, centerY + heartSize,
    );

    path.close();

    canvas.drawPath(path, heartPaint);
  }

  void _drawPartyFace(Canvas canvas, Size size, double centerX, double centerY) {
    final faceRadius = min(size.width, size.height) * 0.2;
      
      // Draw the face (simple yellow circle)
      final facePaint = Paint()
        ..color = const Color(0xFFFDBF17)
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(
        Offset(centerX+4, centerY+4), 
        faceRadius, 
        facePaint,
      );
      
      // draw black outline around the face
      final outlinePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = faceRadius * 0.05;
      canvas.drawCircle(
        Offset(centerX+4, centerY+4), 
        faceRadius, 
        outlinePaint,
      );

      // Draw eyebrows (arcs above the eyes)
    final eyebrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = faceRadius * 0.06
      ..strokeCap = StrokeCap.round;
    
    // Left eyebrow
    final leftEyebrowPath = Path();
    final leftEyebrowCenterX = centerX - faceRadius * 0.40;
    final leftEyebrowCenterY = centerY - faceRadius * 0.30;
    
    leftEyebrowPath.addArc(
      Rect.fromCenter(
        center: Offset(leftEyebrowCenterX, leftEyebrowCenterY),
        width: faceRadius * 0.5,
        height: faceRadius * 0.4,
      ),
      pi * 1.0, // Start angle
      pi * 0.6, // Sweep angle
    );
    canvas.drawPath(leftEyebrowPath, eyebrowPaint);
    
    // // Right eyebrow
    final rightEyebrowPath = Path();
    final rightEyebrowCenterX = centerX + faceRadius * 0.40;
    final rightEyebrowCenterY = centerY - faceRadius * 0.30;

    rightEyebrowPath.addArc(
      Rect.fromCenter(
        center: Offset(rightEyebrowCenterX, rightEyebrowCenterY),
        width: faceRadius * 0.5,
        height: faceRadius * 0.4,
      ),
      pi * 1.4, // Start angle
      pi * 0.6, // Sweep angle
    );
    canvas.drawPath(rightEyebrowPath, eyebrowPaint);

    // Draw eyes
    final eyePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = faceRadius * 0.06
      ..strokeCap = StrokeCap.round;
    
    // Left eye (
    final leftEyePath = Path();
    final leftEyeCenterX = centerX - faceRadius * 0.35;
    final leftEyeCenterY = centerY - faceRadius * 0.05;
    
    leftEyePath.addArc(
      Rect.fromCenter(
        center: Offset(leftEyeCenterX, leftEyeCenterY),
        width: faceRadius * 0.35,
        height: faceRadius * 0.25,
      ),
      pi * 1.1, // Start angle 
      pi * 0.6, // Sweep angle
    );
    canvas.drawPath(leftEyePath, eyePaint);
    
    // Right eye
    final rightEyePath = Path();
    final rightEyeCenterX = centerX + faceRadius * 0.35;
    final rightEyeCenterY = centerY - faceRadius * 0.05;
    
    rightEyePath.addArc(
      Rect.fromCenter(
        center: Offset(rightEyeCenterX, rightEyeCenterY),
        width: faceRadius * 0.35,
        height: faceRadius * 0.25,
      ),
      pi * 1.3, // Start angle 
      pi * 0.6, // Sweep angle 
    );
    canvas.drawPath(rightEyePath, eyePaint);

    // Draw mouth 
    final mouthPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = faceRadius * 0.06
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    
    // Draw mouth path
    final mouthPath = Path();
    final mouthCenterX = centerX;
    final mouthCenterY = centerY + faceRadius * 0.40;
    
    // Top curve 
    mouthPath.addArc(
      Rect.fromCenter(
        center: Offset(mouthCenterX, mouthCenterY - faceRadius * 0.05),
        width: faceRadius * 0.27,
        height: faceRadius * 0.25,
      ),
      pi * 1.5, // Start angle
      pi, // Sweep angle
    );
    
    // Bottom curve 
    mouthPath.addArc(
      Rect.fromCenter(
        center: Offset(mouthCenterX, mouthCenterY + faceRadius * 0.20),
        width: faceRadius * 0.27,
        height: faceRadius * 0.25,
      ),
      pi * 0.5, // Start angle
      -pi, // Sweep angle
    );
    
    canvas.drawPath(mouthPath, mouthPaint);
    
    // Draw the tongue
    final tonguePath = Path();
    
    // Start from the middle 
    final tongueStartX = mouthCenterX + faceRadius * 0.10;
    final tongueStartY = mouthCenterY + faceRadius * 0.10;

    // Create a curved tongue
    tonguePath.moveTo(tongueStartX, tongueStartY);

    tonguePath.quadraticBezierTo(
      tongueStartX + faceRadius * 0.60, 
      tongueStartY,                    
      tongueStartX + faceRadius * 0.30, 
      tongueStartY - faceRadius * 0.15 
    );
    canvas.drawPath(tonguePath, mouthPaint);

    _drawConfetti(canvas, size, centerX, centerY);
    _drawPartyHat(canvas, centerX, centerY, faceRadius);
  }

  void _drawPartyHat(Canvas canvas, double centerX, double centerY, double faceRadius) {
    final angle = -120 * pi / 180; // ~10 o’clock position on the circle

    // Anchor point on the circle edge
    final hatBaseX = centerX + faceRadius * cos(angle);
    final hatBaseY = centerY + faceRadius * sin(angle);

    final hatSize = faceRadius * 0.9;

    // Move canvas origin to hat base
    canvas.translate(hatBaseX, hatBaseY);

    // Rotate canvas 
    canvas.rotate(angle + pi / 2);

    // Draw triangle hat
    final hatPath = Path();
    hatPath.moveTo(0, -hatSize * 0.7); // Top point
    hatPath.lineTo(-hatSize * 0.4, hatSize * 0.2); // Bottom left
    hatPath.lineTo(hatSize * 0.4, hatSize * 0.2); // Bottom right
    hatPath.close();

    // draw border around the hat
    final hatBorderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = faceRadius * 0.08;
    canvas.drawPath(hatPath, hatBorderPaint);

    final hatPaint = Paint()
      ..color = const Color(0xFFFF6B35)
      ..style = PaintingStyle.fill;

    canvas.drawPath(hatPath, hatPaint);

  }

  void _drawConfetti(Canvas canvas, Size size, double centerX, double centerY) {
    // Draw various confetti pieces around the face
    final confettiData = [
      {'x': -0.3, 'y': 0.4, 'color': const Color(0xFF9B59B6), 'size': 5.0},
      {'x': 0.5, 'y': -0.3, 'color': const Color(0xFFE74C3C), 'size': 5.0},
      {'x': -0.6, 'y': 0.1, 'color': const Color(0xFF3498DB), 'size': 5.0},
      {'x': 0.0, 'y': 0.5, 'color': const Color(0xFFF39C12), 'size': 5.0},
      {'x': 0.3, 'y': 0.4, 'color': const Color(0xFF9C27B0), 'size': 4.5},
      {'x': -0.5, 'y': -0.3, 'color': const Color(0xFF4CAF50), 'size': 4.0}, 
    ];
      
    for (var confetti in confettiData) {
      final paint = Paint()
        ..color = confetti['color'] as Color
        ..style = PaintingStyle.fill;
          
      canvas.drawCircle(
        Offset(
          centerX + size.width * (confetti['x'] as double) * 0.4,
          centerY + size.height * (confetti['y'] as double) * 0.4
        ),
        confetti['size'] as double,
        paint
      );
    }
      
    // Draw curved arcs
    final curvedArcPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;

    final curvedArc1 = Path();
    curvedArc1.addArc(
      Rect.fromCenter(
        center: Offset(centerX + size.width * -0.25 * 0.4, centerY + size.height * 0.37 * 0.4),
        width: size.width * 0.06,
        height: size.height * 0.06
      ),
      0, // Start angle
      1.5 // Sweep angle 
    );
    canvas.drawPath(curvedArc1, curvedArcPaint);


    final curvedArc2 = Path();
    curvedArc2.addArc(
      Rect.fromCenter(
        center: Offset(centerX + size.width * 0.47 * 0.4, centerY + size.height * -0.32 * 0.4),
        width: size.width * 0.06,
        height: size.height * 0.06
      ),
      -1.5, // Start angle
      1.5 // Sweep angle
    );
    canvas.drawPath(curvedArc2, curvedArcPaint);

    final curvedArc3 = Path();
    curvedArc3.addArc(
      Rect.fromCenter(
        center: Offset(centerX + size.width * -0.57 * 0.4, centerY + size.height * 0.08 * 0.4),
        width: size.width * 0.06,
        height: size.height * 0.06
      ),
      0.5, // Start angle
      1.2 // Sweep angle
    );
    canvas.drawPath(curvedArc3, curvedArcPaint);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}