import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'video_screen.dart';
import 'survey_screen.dart';
import 'badge_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeContent(),
    const VideoScreen(),
    const SurveyScreen(),
    const Placeholder(), // Placeholder for people screen
    const BadgeScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        'assets/images/Logos-FAIN.png', 
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: Text(
                        'Autorización para Uso de Datos – Encuesta Académica',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'La carrera de Ingeniería Comercial de la Universidad Adventista de Chile está realizando una encuesta con fines académicos. Solicitamos su consentimiento para recopilar algunos datos personales y de opinión, basándose en un servicio de una serie de videos.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Le aseguramos que toda la información será confidencial, usada solo para este estudio y manejada según la normativa de protección de datos.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Al continuar, usted acepta participar voluntariamente y autoriza el uso de sus respuestas para fines investigativos.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Gracias por su colaboración.',
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'Carrera de Ingeniería Comercial – UNACH',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}