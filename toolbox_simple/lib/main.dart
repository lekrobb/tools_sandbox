import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(const ToolboxSandboxApp());
}

class ToolboxSandboxApp extends StatelessWidget {
  const ToolboxSandboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox Sandbox',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
        ),
      ),
      home: const HomePage(title: '🛠️ Boîte à Outils Bac à Sable'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Message de bienvenue
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.build_circle,
                      size: 64,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '🎉 Bienvenue dans votre Bac à Sable Flutter !',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Explorez les fonctionnalités mobiles et apprenez Flutter pas à pas.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Modules disponibles
            Text(
              'Modules Disponibles',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Grille de modules
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
                children: const [
                  _ModuleCard(
                    icon: Icons.calculate,
                    title: 'Calculatrice',
                    description: 'Calculs et conversions',
                    color: Colors.blue,
                    route: '/calculator',
                  ),
                  _ModuleCard(
                    icon: Icons.location_on,
                    title: 'Géolocalisation',
                    description: 'GPS et cartes',
                    color: Colors.green,
                    route: '/location',
                  ),
                  _ModuleCard(
                    icon: Icons.folder,
                    title: 'Fichiers',
                    description: 'Gestion documents',
                    color: Colors.orange,
                    route: '/files',
                  ),
                  _ModuleCard(
                    icon: Icons.cloud,
                    title: 'Réseau',
                    description: 'APIs et données',
                    color: Colors.purple,
                    route: '/network',
                  ),
                  _ModuleCard(
                    icon: Icons.mic,
                    title: 'Audio & Voix',
                    description: 'Speech to text',
                    color: Colors.red,
                    route: '/audio',
                  ),
                  _ModuleCard(
                    icon: Icons.share,
                    title: 'Partage',
                    description: 'Partage social',
                    color: Colors.teal,
                    route: '/sharing',
                  ),
                  _ModuleCard(
                    icon: Icons.sensors,
                    title: 'Capteurs',
                    description: 'Hardware device',
                    color: Colors.indigo,
                    route: '/sensors',
                  ),
                  _ModuleCard(
                    icon: Icons.bluetooth,
                    title: 'Bluetooth',
                    description: 'Connexions sans fil',
                    color: Colors.cyan,
                    route: '/bluetooth',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final String route;

  const _ModuleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          // Navigation spécialisée selon le module
          if (title == 'Calculatrice') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CalculatorPage(),
              ),
            );
          } else if (title == 'Géolocalisation') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LocationPage(),
              ),
            );
          } else if (title == 'Fichiers') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FilesPage(),
              ),
            );
          } else if (title == 'Réseau') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NetworkPage(),
              ),
            );
          } else if (title == 'Audio & Voix') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AudioPage(),
              ),
            );
          } else if (title == 'Partage') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SharingPage(),
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ModulePage(
                  title: title,
                  icon: icon,
                  color: color,
                ),
              ),
            );
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Page générique pour les modules (pour l'instant)
class ModulePage extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const ModulePage({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                size: 80,
                color: color,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Module en cours de développement',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '🚧 Bientôt disponible !',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Retour'),
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Page Calculatrice Fonctionnelle
class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = '0';
  String _expression = '';
  double _result = 0;
  String _operation = '';
  double _operand = 0;
  bool _waitingForOperand = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔢 Calculatrice'),
        backgroundColor: Colors.blue.withOpacity(0.1),
        foregroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Historique - Bientôt disponible !')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Écran d'affichage
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.grey[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (_expression.isNotEmpty)
                    Text(
                      _expression,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  const SizedBox(height: 10),
                  Text(
                    _display,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),

          // Boutons de la calculatrice
          Expanded(
            flex: 3,
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  _buildButtonRow(['C', '⌫', '%', '÷']),
                  _buildButtonRow(['7', '8', '9', '×']),
                  _buildButtonRow(['4', '5', '6', '-']),
                  _buildButtonRow(['1', '2', '3', '+']),
                  _buildButtonRow(['0', '.', '=']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        children: buttons.map((button) {
          return Expanded(
            flex: (button == '0') ? 2 : 1,
            child: Container(
              margin: const EdgeInsets.all(4),
              child: ElevatedButton(
                onPressed: () => _onButtonPressed(button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _getButtonColor(button),
                  foregroundColor: _getButtonTextColor(button),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 2,
                ),
                child: Text(
                  button,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == 'C' || button == '⌫') {
      return Colors.red[400]!;
    } else if ('÷×-+='.contains(button)) {
      return Colors.blue[600]!;
    } else if (button == '%') {
      return Colors.orange[400]!;
    } else {
      return Colors.grey[300]!;
    }
  }

  Color _getButtonTextColor(String button) {
    if (button == 'C' || button == '⌫' || '÷×-+='.contains(button) || button == '%') {
      return Colors.white;
    } else {
      return Colors.black87;
    }
  }

  void _onButtonPressed(String button) {
    setState(() {
      switch (button) {
        case 'C':
          _clear();
          break;
        case '⌫':
          _backspace();
          break;
        case '=':
          _calculate();
          break;
        case '+':
        case '-':
        case '×':
        case '÷':
        case '%':
          _setOperation(button);
          break;
        case '.':
          _addDecimal();
          break;
        default:
          _addNumber(button);
      }
    });
  }

  void _clear() {
    _display = '0';
    _expression = '';
    _result = 0;
    _operation = '';
    _operand = 0;
    _waitingForOperand = false;
  }

  void _backspace() {
    if (_display.length > 1) {
      _display = _display.substring(0, _display.length - 1);
    } else {
      _display = '0';
    }
  }

  void _addNumber(String number) {
    if (_waitingForOperand) {
      _display = number;
      _waitingForOperand = false;
    } else {
      _display = _display == '0' ? number : _display + number;
    }
  }

  void _addDecimal() {
    if (_waitingForOperand) {
      _display = '0.';
      _waitingForOperand = false;
    } else if (!_display.contains('.')) {
      _display += '.';
    }
  }

  void _setOperation(String operation) {
    if (_operation.isNotEmpty && !_waitingForOperand) {
      _calculate();
    }
    
    _operand = double.parse(_display);
    _operation = operation;
    _expression = '$_display $operation';
    _waitingForOperand = true;
  }

  void _calculate() {
    if (_operation.isEmpty || _waitingForOperand) return;

    double currentValue = double.parse(_display);
    
    switch (_operation) {
      case '+':
        _result = _operand + currentValue;
        break;
      case '-':
        _result = _operand - currentValue;
        break;
      case '×':
        _result = _operand * currentValue;
        break;
      case '÷':
        if (currentValue != 0) {
          _result = _operand / currentValue;
        } else {
          _display = 'Erreur';
          _clear();
          return;
        }
        break;
      case '%':
        _result = _operand % currentValue;
        break;
    }

    _display = _result.toString();
    if (_display.endsWith('.0')) {
      _display = _display.substring(0, _display.length - 2);
    }
    
    _expression = '$_operand $_operation $currentValue =';
    _operation = '';
    _waitingForOperand = true;
  }
}

// Page Géolocalisation
class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String _locationInfo = 'Appuyez pour obtenir votre position GPS';
  String _address = '';
  bool _isLoading = false;
  Position? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📍 Géolocalisation'),
        backgroundColor: Colors.green.withOpacity(0.1),
        foregroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showLocationDetails(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.my_location, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Position Actuelle', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isLoading)
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 12),
                            Text('🔍 Obtention de votre position...'),
                          ],
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_locationInfo),
                          if (_address.isNotEmpty) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('📍 Adresse:', style: TextStyle(fontWeight: FontWeight.bold)),
                                  Text(_address),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _getCurrentLocation,
              icon: const Icon(Icons.gps_fixed),
              label: const Text('Obtenir ma Position'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            if (_currentPosition != null) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('🎯 Actions Disponibles', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _shareLocation,
                              icon: const Icon(Icons.share),
                              label: const Text('Partager'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _openInMaps,
                              icon: const Icon(Icons.map),
                              label: const Text('Cartes'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
      _locationInfo = 'Vérification des permissions...';
    });

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _locationInfo = '❌ Permission GPS refusée. Activez la géolocalisation dans les paramètres.';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _locationInfo = '❌ Permission GPS refusée définitivement. Activez la géolocalisation dans les paramètres système.';
          _isLoading = false;
        });
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _locationInfo = '❌ Service de localisation désactivé. Activez le GPS dans les paramètres.';
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _locationInfo = '🔍 Obtention de votre position GPS...';
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentPosition = position;
        _locationInfo = '''✅ Position obtenue avec succès !

📍 Coordonnées:
  Latitude: ${position.latitude.toStringAsFixed(6)}
  Longitude: ${position.longitude.toStringAsFixed(6)}
  Altitude: ${position.altitude.toStringAsFixed(1)}m
  Précision: ±${position.accuracy.toStringAsFixed(1)}m

⏱️ Timestamp: ${DateTime.fromMillisecondsSinceEpoch(position.timestamp!.millisecondsSinceEpoch).toString().substring(0, 19)}''';
      });

      // Géocodage inverse
      try {
        List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          setState(() {
            _address = '''${place.street ?? ''}${place.street != null && place.street!.isNotEmpty ? '\n' : ''}${place.locality ?? ''} ${place.postalCode ?? ''}
${place.administrativeArea ?? ''}, ${place.country ?? ''}''';
          });
        }
      } catch (e) {
        print('Erreur géocodage: $e');
      }

    } catch (e) {
      setState(() {
        _locationInfo = '❌ Erreur lors de l\'obtention de la position: $e';
        _isLoading = false;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showLocationDetails() {
    if (_currentPosition == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Aucune position disponible. Obtenez d\'abord votre position.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🔍 Détails Avancés'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Vitesse', '${_currentPosition!.speed.toStringAsFixed(1)} m/s'),
              _buildDetailRow('Cap', '${_currentPosition!.heading.toStringAsFixed(1)}°'),
              _buildDetailRow('Altitude précision', '±${_currentPosition!.altitudeAccuracy.toStringAsFixed(1)}m'),
              _buildDetailRow('Précision horizontale', '±${_currentPosition!.accuracy.toStringAsFixed(1)}m'),
              const Divider(),
              const Text('🌐 Coordonnées pour développeurs:', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SelectableText('Lat: ${_currentPosition!.latitude}'),
              SelectableText('Lng: ${_currentPosition!.longitude}'),
              SelectableText('Alt: ${_currentPosition!.altitude}'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(value),
        ],
      ),
    );
  }

  void _shareLocation() {
    if (_currentPosition == null) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Partage de position - Fonctionnalité bientôt disponible !')),
    );
  }

  void _openInMaps() {
    if (_currentPosition == null) return;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ouverture dans Google Maps - Fonctionnalité bientôt disponible !')),
    );
  }
}

// Page Gestion de Fichiers
class FilesPage extends StatefulWidget {
  const FilesPage({super.key});

  @override
  State<FilesPage> createState() => _FilesPageState();
}

class _FilesPageState extends State<FilesPage> {
  List<FileSystemEntity> _files = [];
  String _currentPath = '';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDocumentsDirectory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📁 Gestionnaire de Fichiers'),
        backgroundColor: Colors.orange.withOpacity(0.1),
        foregroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: const Icon(Icons.note_add),
            onPressed: _createTestFile,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _loadFiles(_currentPath),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chemin actuel
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.grey[100],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('📍 Dossier actuel:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(_currentPath, style: const TextStyle(fontSize: 12, fontFamily: 'monospace')),
              ],
            ),
          ),
          
          // Actions rapides
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _createTestFile,
                    icon: const Icon(Icons.note_add),
                    label: const Text('Créer Fichier Test'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _createTestFolder,
                    icon: const Icon(Icons.create_new_folder),
                    label: const Text('Créer Dossier'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Liste des fichiers
          Expanded(
            child: _isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Chargement des fichiers...'),
                      ],
                    ),
                  )
                : _files.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.folder_open, size: 64, color: Colors.grey),
                            SizedBox(height: 16),
                            Text('Aucun fichier dans ce dossier'),
                            SizedBox(height: 8),
                            Text('Créez un fichier test pour commencer !'),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: _files.length,
                        itemBuilder: (context, index) {
                          final file = _files[index];
                          final fileName = file.path.split(Platform.pathSeparator).last;
                          final isDirectory = file is Directory;
                          
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              leading: Icon(
                                isDirectory ? Icons.folder : _getFileIcon(fileName),
                                color: isDirectory ? Colors.blue : Colors.orange,
                                size: 32,
                              ),
                              title: Text(fileName, style: const TextStyle(fontWeight: FontWeight.w500)),
                              subtitle: Text(
                                isDirectory ? 'Dossier' : _getFileInfo(file),
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (!isDirectory) ...[
                                    IconButton(
                                      icon: const Icon(Icons.visibility),
                                      onPressed: () => _viewFile(file.path),
                                    ),
                                  ],
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteFile(file),
                                  ),
                                ],
                              ),
                              onTap: isDirectory ? () => _openDirectory(file.path) : () => _viewFile(file.path),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  IconData _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'txt': return Icons.description;
      case 'json': return Icons.code;
      case 'jpg':
      case 'jpeg':
      case 'png': return Icons.image;
      case 'pdf': return Icons.picture_as_pdf;
      default: return Icons.insert_drive_file;
    }
  }

  String _getFileInfo(FileSystemEntity file) {
    try {
      final stat = (file as File).statSync();
      final size = stat.size;
      final modified = stat.modified;
      
      String sizeStr;
      if (size < 1024) {
        sizeStr = '${size}B';
      } else if (size < 1024 * 1024) {
        sizeStr = '${(size / 1024).toStringAsFixed(1)}KB';
      } else {
        sizeStr = '${(size / (1024 * 1024)).toStringAsFixed(1)}MB';
      }
      
      return '$sizeStr • ${modified.toString().substring(0, 16)}';
    } catch (e) {
      return 'Fichier';
    }
  }

  Future<void> _loadDocumentsDirectory() async {
    setState(() { _isLoading = true; });
    try {
      final directory = await getApplicationDocumentsDirectory();
      setState(() { _currentPath = directory.path; });
      await _loadFiles(directory.path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _loadFiles(String path) async {
    setState(() { _isLoading = true; });
    try {
      final directory = Directory(path);
      if (await directory.exists()) {
        final files = directory.listSync()..sort((a, b) {
          // Dossiers en premier, puis fichiers, triés alphabétiquement
          final aIsDir = a is Directory;
          final bIsDir = b is Directory;
          if (aIsDir && !bIsDir) return -1;
          if (!aIsDir && bIsDir) return 1;
          return a.path.split(Platform.pathSeparator).last
              .compareTo(b.path.split(Platform.pathSeparator).last);
        });
        setState(() { _files = files; });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur: $e')));
    } finally {
      setState(() { _isLoading = false; });
    }
  }

  Future<void> _openDirectory(String path) async {
    setState(() { _currentPath = path; });
    await _loadFiles(path);
  }

  Future<void> _createTestFile() async {
    try {
      final directory = Directory(_currentPath);
      final fileName = 'test_${DateTime.now().millisecondsSinceEpoch}.txt';
      final file = File('${directory.path}${Platform.pathSeparator}$fileName');
      
      await file.writeAsString('''🛠️ Fichier Test Toolbox Sandbox
Créé le: ${DateTime.now()}
Dossier: ${directory.path}

Votre bac à sable Flutter fonctionne parfaitement ! 🚀

Contenu d'exemple:
- Ligne 1
- Ligne 2  
- Ligne 3

Fin du fichier test.''');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Fichier créé: $fileName'), backgroundColor: Colors.green),
      );
      _loadFiles(_currentPath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Erreur: $e')));
    }
  }

  Future<void> _createTestFolder() async {
    try {
      final directory = Directory(_currentPath);
      final folderName = 'dossier_${DateTime.now().millisecondsSinceEpoch}';
      final newFolder = Directory('${directory.path}${Platform.pathSeparator}$folderName');
      
      await newFolder.create();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Dossier créé: $folderName'), backgroundColor: Colors.green),
      );
      _loadFiles(_currentPath);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Erreur: $e')));
    }
  }

  Future<void> _viewFile(String filePath) async {
    try {
      final file = File(filePath);
      final content = await file.readAsString();
      final fileName = filePath.split(Platform.pathSeparator).last;
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(_getFileIcon(fileName), color: Colors.orange),
              const SizedBox(width: 8),
              Expanded(child: Text(fileName, style: const TextStyle(fontSize: 16))),
            ],
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Text(
                  content, 
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 12)
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Fermer'),
            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _editFile(filePath, content);
              },
              icon: const Icon(Icons.edit),
              label: const Text('Éditer'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Erreur: $e')));
    }
  }

  Future<void> _editFile(String filePath, String currentContent) async {
    final controller = TextEditingController(text: currentContent);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('✏️ Éditer le fichier'),
        content: SizedBox(
          width: double.maxFinite,
          height: 300,
          child: TextField(
            controller: controller,
            maxLines: null,
            expands: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Contenu du fichier...',
            ),
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                final file = File(filePath);
                await file.writeAsString(controller.text);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ Fichier sauvegardé'), backgroundColor: Colors.green),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Erreur: $e')));
              }
            },
            icon: const Icon(Icons.save),
            label: const Text('Sauvegarder'),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteFile(FileSystemEntity file) async {
    final fileName = file.path.split(Platform.pathSeparator).last;
    final isDirectory = file is Directory;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🗑️ Supprimer ${isDirectory ? 'le dossier' : 'le fichier'}'),
        content: Text('Êtes-vous sûr de vouloir supprimer "$fileName" ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              try {
                await file.delete(recursive: true);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('✅ ${isDirectory ? 'Dossier' : 'Fichier'} supprimé'), backgroundColor: Colors.green),
                );
                _loadFiles(_currentPath);
              } catch (e) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('❌ Erreur: $e')));
              }
            },
            icon: const Icon(Icons.delete),
            label: const Text('Supprimer'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

// Page Communication Réseau Avancée
class NetworkPage extends StatefulWidget {
  const NetworkPage({super.key});

  @override
  State<NetworkPage> createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {
  final _urlController = TextEditingController(text: 'https://jsonplaceholder.typicode.com/posts/1');
  final _headersController = TextEditingController();
  final _bodyController = TextEditingController();
  String _selectedMethod = 'GET';
  String _response = '';
  bool _isLoading = false;
  int? _statusCode;
  Map<String, String> _responseHeaders = {};
  bool _ignoreSslErrors = false;
  int _timeoutSeconds = 30;
  
  // Templates d'APIs populaires
  final Map<String, Map<String, String>> _apiTemplates = {
    'JSONPlaceholder - Posts': {
      'url': 'https://jsonplaceholder.typicode.com/posts',
      'method': 'GET',
      'description': 'API de test avec posts factices'
    },
    'JSONPlaceholder - Users': {
      'url': 'https://jsonplaceholder.typicode.com/users',
      'method': 'GET',
      'description': 'Liste des utilisateurs factices'
    },
    'JSONPlaceholder - Single Post': {
      'url': 'https://jsonplaceholder.typicode.com/posts/1',
      'method': 'GET',
      'description': 'Un post spécifique'
    },
    'GitHub API - User': {
      'url': 'https://api.github.com/users/octocat',
      'method': 'GET',
      'description': 'Profil utilisateur GitHub'
    },
    'Random Quote': {
      'url': 'https://api.quotable.io/random',
      'method': 'GET',
      'description': 'Citation aléatoire en anglais'
    },
    'Cat Facts': {
      'url': 'https://catfact.ninja/fact',
      'method': 'GET',
      'description': 'Fait aléatoire sur les chats'
    },
    'Random Dog Image': {
      'url': 'https://dog.ceo/api/breeds/image/random',
      'method': 'GET',
      'description': 'Image aléatoire de chien'
    },
    'POST Example': {
      'url': 'https://jsonplaceholder.typicode.com/posts',
      'method': 'POST',
      'description': 'Exemple de création de post'
    },
    'API Peso - Local': {
      'url': 'https://localhost:8080/api/endpoint',
      'method': 'GET',
      'description': 'Template pour API Peso locale (activez SSL ignoré)'
    },
    'API Peso - Dev': {
      'url': 'https://dev-peso.example.com/api/endpoint',
      'method': 'GET',
      'description': 'Template pour API Peso développement'
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌐 Client HTTP Avancé'),
        backgroundColor: Colors.purple.withOpacity(0.1),
        foregroundColor: Colors.purple,
        actions: [
          IconButton(
            icon: const Icon(Icons.api),
            onPressed: () => _showApiTemplates(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section Templates d'APIs
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.api, color: Colors.purple),
                        const SizedBox(width: 8),
                        const Text('🚀 Templates d\'APIs Populaires', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: _showApiTemplates,
                          icon: const Icon(Icons.list),
                          label: const Text('Voir tout'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _apiTemplates.keys.take(4).map((template) {
                        return ActionChip(
                          label: Text(template, style: const TextStyle(fontSize: 11)),
                          onPressed: () => _loadTemplate(template),
                          backgroundColor: Colors.purple.withOpacity(0.1),
                          avatar: Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              color: _getMethodColorForString(_apiTemplates[template]!['method']!),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Center(
                              child: Text(
                                _apiTemplates[template]!['method']!.substring(0, 1),
                                style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Configuration de la requête
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.settings, color: Colors.purple),
                        const SizedBox(width: 8),
                        const Text('⚙️ Configuration Requête', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Méthode HTTP
                    Row(
                      children: [
                        const Text('Méthode HTTP: ', style: TextStyle(fontWeight: FontWeight.w500)),
                        const SizedBox(width: 8),
                        DropdownButton<String>(
                          value: _selectedMethod,
                          items: ['GET', 'POST', 'PUT', 'DELETE', 'PATCH'].map((method) => 
                            DropdownMenuItem(value: method, child: Text(method))
                          ).toList(),
                          onChanged: (value) => setState(() => _selectedMethod = value!),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getMethodColor().withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(_selectedMethod, style: TextStyle(color: _getMethodColor(), fontWeight: FontWeight.bold, fontSize: 12)),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // URL personnalisée avec label amélioré
                    TextField(
                      controller: _urlController,
                      decoration: InputDecoration(
                        labelText: '🌐 URL personnalisée *',
                        hintText: 'https://api.example.com/endpoint',
                        helperText: 'Entrez l\'URL complète de l\'API que vous souhaitez tester',
                        border: const OutlineInputBorder(),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => _urlController.clear(),
                            ),
                            IconButton(
                              icon: const Icon(Icons.content_paste),
                              onPressed: _pasteFromClipboard,
                            ),
                          ],
                        ),
                      ),
                      maxLines: 2,
                      minLines: 1,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Headers personnalisés
                    TextField(
                      controller: _headersController,
                      decoration: const InputDecoration(
                        labelText: '📋 Headers personnalisés (JSON)',
                        hintText: '{"Authorization": "Bearer token", "Content-Type": "application/json"}',
                        helperText: 'Optionnel - Format JSON pour les en-têtes HTTP',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      minLines: 1,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Body pour POST/PUT/PATCH
                    if (['POST', 'PUT', 'PATCH'].contains(_selectedMethod)) ...[
                      TextField(
                        controller: _bodyController,
                        decoration: InputDecoration(
                          labelText: '📝 Corps de la requête (JSON)',
                          hintText: '{"title": "Mon titre", "body": "Contenu du message", "userId": 1}',
                          helperText: 'Corps de la requête pour ${_selectedMethod}',
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 4,
                        minLines: 2,
                      ),
                      const SizedBox(height: 16),
                    ],
                    
                    // Options avancées
                    ExpansionTile(
                      title: const Text('⚙️ Options Avancées'),
                      children: [
                        const SizedBox(height: 8),
                        // Ignorer les erreurs SSL
                        CheckboxListTile(
                          title: const Text('🔓 Ignorer les erreurs SSL/TLS'),
                          subtitle: const Text('Utile pour les APIs de développement ou certificats auto-signés'),
                          value: _ignoreSslErrors,
                          onChanged: (value) => setState(() => _ignoreSslErrors = value!),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        
                        // Timeout
                        ListTile(
                          title: const Text('⏱️ Timeout de requête'),
                          subtitle: Text('${_timeoutSeconds}s'),
                          trailing: SizedBox(
                            width: 100,
                            child: Slider(
                              value: _timeoutSeconds.toDouble(),
                              min: 5,
                              max: 120,
                              divisions: 23,
                              label: '${_timeoutSeconds}s',
                              onChanged: (value) => setState(() => _timeoutSeconds = value.round()),
                            ),
                          ),
                        ),
                        
                        const SizedBox(height: 8),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Bouton d'envoi
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _makeRequest,
                        icon: _isLoading 
                          ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) 
                          : const Icon(Icons.send),
                        label: Text(_isLoading ? 'Envoi en cours...' : 'Envoyer Requête $_selectedMethod'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Réponse
            if (_response.isNotEmpty) ...[
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.download, color: Colors.green),
                          const SizedBox(width: 8),
                          const Text('📥 Réponse du Serveur', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          const Spacer(),
                          if (_statusCode != null)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor().withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text('$_statusCode ${_getStatusText()}', 
                                style: TextStyle(color: _getStatusColor(), fontWeight: FontWeight.bold)),
                            ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Headers de réponse
                      if (_responseHeaders.isNotEmpty) ...[
                        ExpansionTile(
                          title: Text('📋 Headers de Réponse (${_responseHeaders.length})'),
                          children: [
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _responseHeaders.entries.map((entry) => 
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 2),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('${entry.key}: ', 
                                          style: const TextStyle(fontFamily: 'monospace', fontSize: 12, fontWeight: FontWeight.bold)),
                                        Expanded(
                                          child: Text(entry.value, 
                                            style: const TextStyle(fontFamily: 'monospace', fontSize: 12)),
                                        ),
                                      ],
                                    ),
                                  )
                                ).toList(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                      
                      // Corps de la réponse
                      Container(
                        width: double.infinity,
                        height: 300,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: SingleChildScrollView(
                          child: SelectableText(
                            _formatResponse(_response), 
                            style: const TextStyle(fontFamily: 'monospace', fontSize: 12)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _showApiTemplates() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.api, color: Colors.purple),
                const SizedBox(width: 8),
                const Text('🚀 Templates d\'APIs Populaires', 
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _apiTemplates.length,
                itemBuilder: (context, index) {
                  final template = _apiTemplates.keys.elementAt(index);
                  final data = _apiTemplates[template]!;
                  return Card(
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getMethodColorForString(data['method']!).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(data['method']!, 
                          style: TextStyle(color: _getMethodColorForString(data['method']!), fontWeight: FontWeight.bold, fontSize: 12)),
                      ),
                      title: Text(template, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['description']!),
                          const SizedBox(height: 4),
                          Text(data['url']!, 
                            style: TextStyle(fontSize: 11, color: Colors.grey[600], fontFamily: 'monospace')),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        _loadTemplate(template);
                        Navigator.pop(context);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadTemplate(String templateName) {
    final template = _apiTemplates[templateName];
    if (template != null) {
      setState(() {
        _urlController.text = template['url']!;
        _selectedMethod = template['method']!;
        _headersController.clear();
        _bodyController.clear();
        
        // Ajouter du contenu par défaut pour les requêtes POST
        if (template['method'] == 'POST' && templateName == 'POST Example') {
          _bodyController.text = '''{
  "title": "Mon nouveau post",
  "body": "Ceci est le contenu de mon post de test",
  "userId": 1
}''';
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('✅ Template "$templateName" chargé'), backgroundColor: Colors.green),
      );
    }
  }

  void _pasteFromClipboard() {
    // Fonctionnalité de collage - à implémenter avec clipboard package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fonctionnalité de collage - Bientôt disponible !')),
    );
  }

  Future<void> _makeRequest() async {
    if (_urlController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Veuillez entrer une URL'), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() { 
      _isLoading = true; 
      _response = ''; 
      _responseHeaders = {};
    });

    try {
      final url = Uri.parse(_urlController.text.trim());
      
      // Parse headers
      Map<String, String> headers = {};
      if (_headersController.text.isNotEmpty) {
        try {
          final headersJson = json.decode(_headersController.text);
          headers = Map<String, String>.from(headersJson);
        } catch (e) {
          throw Exception('Format headers invalide. Utilisez du JSON valide: $e');
        }
      }
      
      // Ajouter Content-Type par défaut pour POST/PUT/PATCH
      if (['POST', 'PUT', 'PATCH'].contains(_selectedMethod) && !headers.containsKey('Content-Type')) {
        headers['Content-Type'] = 'application/json';
      }
      
      // Créer un client HTTP personnalisé si on ignore les erreurs SSL
      http.Client client;
      if (_ignoreSslErrors) {
        final httpClient = HttpClient();
        httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        client = IOClient(httpClient);
      } else {
        client = http.Client();
      }
      
      http.Response response;
      final timeout = Duration(seconds: _timeoutSeconds);
      
      // Afficher les détails de la requête pour debug
      final debugInfo = '''
🔍 DÉTAILS DE LA REQUÊTE:
📍 URL: ${url.toString()}
🔧 Méthode: $_selectedMethod
⏱️ Timeout: ${_timeoutSeconds}s
🔓 SSL ignoré: $_ignoreSslErrors
📋 Headers: ${headers.isEmpty ? 'Aucun' : headers.toString()}
${['POST', 'PUT', 'PATCH'].contains(_selectedMethod) && _bodyController.text.isNotEmpty ? '📝 Body: ${_bodyController.text}' : ''}

⏳ Envoi en cours...
''';
      
      setState(() {
        _response = debugInfo;
      });
      
      try {
        switch (_selectedMethod) {
          case 'GET':
            response = await client.get(url, headers: headers).timeout(timeout);
            break;
          case 'POST':
            response = await client.post(url, headers: headers, body: _bodyController.text).timeout(timeout);
            break;
          case 'PUT':
            response = await client.put(url, headers: headers, body: _bodyController.text).timeout(timeout);
            break;
          case 'DELETE':
            response = await client.delete(url, headers: headers).timeout(timeout);
            break;
          case 'PATCH':
            response = await client.patch(url, headers: headers, body: _bodyController.text).timeout(timeout);
            break;
          default:
            throw Exception('Méthode HTTP non supportée: $_selectedMethod');
        }
      } finally {
        client.close();
      }
      
      setState(() {
        _statusCode = response.statusCode;
        _response = response.body;
        _responseHeaders = response.headers;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Requête $_selectedMethod terminée - Status: $_statusCode'), 
          backgroundColor: _getStatusColor(),
          duration: const Duration(seconds: 2),
        ),
      );

    } catch (e) {
      String errorMessage = '❌ ERREUR DÉTAILLÉE:\n\n';
      
      if (e.toString().contains('HandshakeException')) {
        errorMessage += '''🔐 ERREUR SSL/TLS (HandshakeException):
Votre API utilise probablement un certificat SSL invalide ou auto-signé.

💡 SOLUTIONS:
1. ✅ Cochez "Ignorer les erreurs SSL/TLS" dans les options avancées
2. 🔧 Demandez à votre équipe d'installer un certificat SSL valide
3. 🌐 Utilisez HTTP au lieu de HTTPS pour les tests locaux

Erreur technique: ${e.toString()}''';
      } else if (e.toString().contains('TimeoutException')) {
        errorMessage += '''⏱️ TIMEOUT:
La requête a pris trop de temps (>${_timeoutSeconds}s).

💡 SOLUTIONS:
1. ⏱️ Augmentez le timeout dans les options avancées
2. 🌐 Vérifiez que votre API répond correctement
3. 📶 Vérifiez votre connexion internet

Erreur technique: ${e.toString()}''';
      } else if (e.toString().contains('SocketException')) {
        errorMessage += '''🌐 ERREUR DE CONNEXION:
Impossible de joindre le serveur.

💡 SOLUTIONS:
1. 🔗 Vérifiez l'URL de votre API
2. 📶 Vérifiez votre connexion internet
3. 🔥 Vérifiez que votre serveur est démarré
4. 🛡️ Vérifiez les pare-feux

Erreur technique: ${e.toString()}''';
      } else {
        errorMessage += 'Type: ${e.runtimeType}\n\nMessage: ${e.toString()}';
      }
      
      setState(() {
        _response = errorMessage;
        _statusCode = null;
        _responseHeaders = {};
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Erreur: ${_getErrorSummary(e.toString())}'), 
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
        ),
      );
    } finally {
      setState(() { _isLoading = false; });
    }
  }
  
  String _getErrorSummary(String error) {
    if (error.contains('HandshakeException')) {
      return 'Erreur SSL - Activez "Ignorer SSL" dans les options';
    } else if (error.contains('TimeoutException')) {
      return 'Timeout - Augmentez le délai d\'attente';
    } else if (error.contains('SocketException')) {
      return 'Connexion impossible - Vérifiez l\'URL';
    } else {
      return 'Erreur de requête';
    }
  }

  String _formatResponse(String response) {
    try {
      final jsonObject = json.decode(response);
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(jsonObject);
    } catch (e) {
      return response;
    }
  }

  Color _getStatusColor() {
    if (_statusCode == null) return Colors.grey;
    if (_statusCode! >= 200 && _statusCode! < 300) return Colors.green;
    if (_statusCode! >= 400) return Colors.red;
    return Colors.orange;
  }

  String _getStatusText() {
    if (_statusCode == null) return '';
    if (_statusCode! == 200) return 'OK';
    if (_statusCode! == 201) return 'Created';
    if (_statusCode! == 400) return 'Bad Request';
    if (_statusCode! == 401) return 'Unauthorized';
    if (_statusCode! == 404) return 'Not Found';
    if (_statusCode! == 500) return 'Server Error';
    return '';
  }

  Color _getMethodColor() {
    return _getMethodColorForString(_selectedMethod);
  }

  Color _getMethodColorForString(String method) {
    switch (method) {
      case 'GET': return Colors.blue;
      case 'POST': return Colors.green;
      case 'PUT': return Colors.orange;
      case 'DELETE': return Colors.red;
      case 'PATCH': return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  void dispose() {
    _urlController.dispose();
    _headersController.dispose();
    _bodyController.dispose();
    super.dispose();
  }
}

// Page Audio & Reconnaissance Vocale (Version simplifiée)
class AudioPage extends StatefulWidget {
  const AudioPage({super.key});

  @override
  State<AudioPage> createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage> {
  String _speechText = 'Appuyez sur le microphone pour commencer';
  String _ttsText = 'Bonjour ! Ceci est un test de synthèse vocale.';
  bool _isListening = false;
  bool _isSpeaking = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎤 Audio & Reconnaissance Vocale'),
        backgroundColor: Colors.red.withOpacity(0.1),
        foregroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section Speech-to-Text
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.mic, color: Colors.red),
                        const SizedBox(width: 8),
                        const Text('🎙️ Speech-to-Text', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Texte reconnu:', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(_speechText, style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isListening ? _stopListening : _startListening,
                        icon: Icon(_isListening ? Icons.stop : Icons.mic),
                        label: Text(_isListening ? 'Arrêter l\'écoute' : 'Commencer l\'écoute'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isListening ? Colors.red : Colors.green,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                    if (_isListening) ...[
                      const SizedBox(height: 12),
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 8),
                            Text('🎧 Écoute en cours...', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Section Text-to-Speech
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.volume_up, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text('🔊 Text-to-Speech', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      onChanged: (value) => setState(() => _ttsText = value),
                      decoration: const InputDecoration(
                        labelText: 'Texte à lire',
                        hintText: 'Entrez le texte que vous voulez entendre...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                      controller: TextEditingController(text: _ttsText),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isSpeaking ? null : _speak,
                            icon: const Icon(Icons.play_arrow),
                            label: const Text('Lire le texte'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _isSpeaking ? _stopSpeaking : null,
                            icon: const Icon(Icons.stop),
                            label: const Text('Arrêter'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_isSpeaking) ...[
                      const SizedBox(height: 12),
                      const Center(
                        child: Column(
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(height: 8),
                            Text('🔊 Lecture en cours...', style: TextStyle(color: Colors.blue)),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Section Enregistrement Audio
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.audiotrack, color: Colors.purple),
                        const SizedBox(width: 8),
                        const Text('🎵 Enregistrement Audio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Fonctionnalités d\'enregistrement audio:', style: TextStyle(fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('• 🎙️ Enregistrement haute qualité'),
                        Text('• 📊 Visualisation en temps réel'),
                        Text('• 💾 Sauvegarde automatique'),
                        Text('• 🎧 Lecture des enregistrements'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[300]!),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.build, color: Colors.orange, size: 32),
                          SizedBox(height: 8),
                          Text('🚧 Module en développement', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Les fonctionnalités audio complètes seront disponibles dans la prochaine version.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _startListening() {
    setState(() {
      _isListening = true;
      _speechText = 'Écoute en cours... Parlez maintenant !';
    });

    // Simulation d'écoute
    Future.delayed(const Duration(seconds: 3), () {
      if (_isListening) {
        setState(() {
          _speechText = 'Exemple de texte reconnu : "Bonjour, ceci est un test de reconnaissance vocale."';
          _isListening = false;
        });
      }
    });
  }

  void _stopListening() {
    setState(() {
      _isListening = false;
      _speechText = 'Écoute arrêtée. Appuyez sur le microphone pour recommencer.';
    });
  }

  void _speak() {
    setState(() {
      _isSpeaking = true;
    });

    // Simulation de lecture
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🔊 Lecture simulée du texte...'), backgroundColor: Colors.blue),
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (_isSpeaking) {
        setState(() {
          _isSpeaking = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Lecture terminée'), backgroundColor: Colors.green),
        );
      }
    });
  }

  void _stopSpeaking() {
    setState(() {
      _isSpeaking = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⏹️ Lecture arrêtée'), backgroundColor: Colors.red),
    );
  }
}

// Page Partage Social (Version simplifiée)
class SharingPage extends StatefulWidget {
  const SharingPage({super.key});

  @override
  State<SharingPage> createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  final _textController = TextEditingController(text: 'Voici un message à partager depuis l\'app Toolbox Sandbox !');
  final _qrController = TextEditingController(text: 'https://flutter.dev');
  String _qrData = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📤 Partage Social'),
        backgroundColor: Colors.teal.withOpacity(0.1),
        foregroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Section Partage de Texte
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.share, color: Colors.teal),
                        const SizedBox(width: 8),
                        const Text('📝 Partage de Texte', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        labelText: 'Message à partager',
                        hintText: 'Entrez votre message...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _shareText,
                            icon: const Icon(Icons.share),
                            label: const Text('Partager Texte'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _shareToSocial,
                            icon: const Icon(Icons.people),
                            label: const Text('Réseaux Sociaux'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Section QR Code
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.qr_code, color: Colors.purple),
                        const SizedBox(width: 8),
                        const Text('📱 Générateur QR Code', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _qrController,
                      decoration: const InputDecoration(
                        labelText: 'Contenu du QR Code',
                        hintText: 'URL, texte, numéro de téléphone...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _generateQR,
                            icon: const Icon(Icons.qr_code_2),
                            label: const Text('Générer QR'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _scanQR,
                            icon: const Icon(Icons.qr_code_scanner),
                            label: const Text('Scanner QR'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_qrData.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.purple[300]!),
                        ),
                        child: Column(
                          children: [
                            const Icon(Icons.qr_code_2, size: 64, color: Colors.purple),
                            const SizedBox(height: 8),
                            const Text('QR Code généré pour:', style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(_qrData, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Section Partage d'Images
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.image, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text('🖼️ Partage d\'Images', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _pickFromGallery,
                            icon: const Icon(Icons.photo_library),
                            label: const Text('Galerie'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _takePhoto,
                            icon: const Icon(Icons.camera_alt),
                            label: const Text('Caméra'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.orange[300]!),
                      ),
                      child: const Column(
                        children: [
                          Icon(Icons.build, color: Colors.orange, size: 32),
                          SizedBox(height: 8),
                          Text('🚧 Module en développement', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('Le partage d\'images sera disponible dans la prochaine version.'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  void _shareText() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('📤 Partage du texte: "${_textController.text.substring(0, 30)}..."'),
        backgroundColor: Colors.teal,
      ),
    );
    // Ici on utiliserait share_plus une fois les packages réinstallés
  }

  void _shareToSocial() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('📱 Partager vers'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.message, color: Colors.green),
              title: Text('WhatsApp'),
            ),
            ListTile(
              leading: Icon(Icons.send, color: Colors.blue),
              title: Text('Telegram'),
            ),
            ListTile(
              leading: Icon(Icons.email, color: Colors.red),
              title: Text('Email'),
            ),
            ListTile(
              leading: Icon(Icons.more_horiz, color: Colors.grey),
              title: Text('Plus d\'options...'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }

  void _generateQR() {
    setState(() {
      _qrData = _qrController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ QR Code généré !'), backgroundColor: Colors.purple),
    );
  }

  void _scanQR() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📷 Scanner QR - Fonctionnalité bientôt disponible !'), backgroundColor: Colors.orange),
    );
  }

  void _pickFromGallery() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🖼️ Sélection galerie - Fonctionnalité bientôt disponible !'), backgroundColor: Colors.green),
    );
  }

  void _takePhoto() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📸 Prise de photo - Fonctionnalité bientôt disponible !'), backgroundColor: Colors.blue),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _qrController.dispose();
    super.dispose();
  }
}