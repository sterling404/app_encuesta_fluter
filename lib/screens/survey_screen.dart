import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import '../widgets/bottom_nav_bar.dart';
import 'badge_screen.dart';

class SurveyScreen extends StatefulWidget {
  const SurveyScreen({Key? key}) : super(key: key);

  @override
  State<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends State<SurveyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _question1Controller = TextEditingController();
  final TextEditingController _question2Controller = TextEditingController();
  final TextEditingController _question3Controller = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _question1Controller.dispose();
    _question2Controller.dispose();
    _question3Controller.dispose();
    super.dispose();
  }

  Future<void> _submitSurvey() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitting = true;
      });

      try {
        // Get device info
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo? androidInfo;
        IosDeviceInfo? iosInfo;
        String deviceModel = '';
        String osVersion = '';

        try {
          if (Theme.of(context).platform == TargetPlatform.android) {
            androidInfo = await deviceInfo.androidInfo;
            deviceModel = androidInfo.model;
            osVersion = 'Android ${androidInfo.version.release}';
          } else if (Theme.of(context).platform == TargetPlatform.iOS) {
            iosInfo = await deviceInfo.iosInfo;
            deviceModel = iosInfo.model;
            osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
          }
        } catch (e) {
          print('Error getting device info: $e');
          deviceModel = 'Unknown';
          osVersion = 'Unknown';
        }

        // Save to Firestore
        await FirebaseFirestore.instance.collection('surveys').add({
          'questionVCM': _question1Controller.text,
          'bestProject': _question2Controller.text,
          'complexProject': _question3Controller.text,
          'deviceModel': deviceModel,
          'osVersion': osVersion,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Navigate to badge screen
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BadgeScreen()),
        );
      } catch (e) {
        // Show error
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al enviar la encuesta: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isSubmitting = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuesta', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.grey[200],
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.blue),
            onPressed: () {
              // Navigation handled by bottom nav bar
            },
          ),
        ],
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Encuesta',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Que es un proyecto VCM'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _question1Controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su respuesta';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Cual es el mejor Proyecto'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _question2Controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su respuesta';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      const Text('Que proyecto más complejo'),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _question3Controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 12,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese su respuesta';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: _isSubmitting ? null : _submitSurvey,
                          child: _isSubmitting
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Enviar',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(width: 5),
                                    Icon(Icons.send, color: Colors.white),
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // Eliminando la barra de navegación duplicada
    );
  }
}