import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass_plus/flutter_liquid_glass.dart';
import 'package:weather_app/constants/colorConstant.dart';

class LiquidGlassDemo extends StatefulWidget {
  const LiquidGlassDemo({super.key});

  @override
  State<LiquidGlassDemo> createState() => _LiquidGlassDemoState();
}

class _LiquidGlassDemoState extends State<LiquidGlassDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // This is the content that will be behind the glass
          // Positioned.fill(
          //   child: Image.network(
          //     'https://picsum.photos/seed/glass/800/800',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          // Container(color: Colorconstant.blackcolor),
          // The LiquidGlassLayer manages glass rendering
          Center(
            child: LiquidGlassLayer(
              settings: const LiquidGlassSettings(
                thickness: 20,
                blur: 10,
                glassColor: Color(0x33FFFFFF),
              ),
              child: LiquidGlass(
                shape: LiquidRoundedSuperellipse(borderRadius: 50),
                child: const SizedBox(
                  height: 200,
                  width: 200,
                  child: Center(child: FlutterLogo(size: 100)),
                ),
              ),
            ),
          ),

          Center(
            child: LiquidGlassLayer(
              settings: const LiquidGlassSettings(
                thickness: 20,
                blur: 10,
                glassColor: Color(0x33FFFFFF),
              ),
              child: LiquidGlass(
                shape: LiquidRoundedSuperellipse(borderRadius: 50),
                child: const SizedBox(height: 100, width: 100, child: Center()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
