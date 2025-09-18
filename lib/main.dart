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
                      painter: SmileyFacePainter(),
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
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final faceRadius = min(size.width, size.height) * 0.2; // Responsive size
    
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}