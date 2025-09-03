import 'package:flutter/material.dart';

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
