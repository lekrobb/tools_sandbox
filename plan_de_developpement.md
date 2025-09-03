# Plan de Développement - Application "Boîte à Outils Bac à Sable"

## 🚀 Vue d'ensemble

Ce plan détaille la mise en place de l'environnement de développement Flutter et le développement progressif de l'application bac à sable, conçu pour un développeur débutant en Flutter.

## 📋 Prérequis système

### Configuration minimale requise
- **OS :** Windows 10+ / macOS 10.14+ / Linux Ubuntu 18.04+
- **RAM :** 8GB minimum (16GB recommandé)
- **Stockage :** 10GB d'espace libre
- **Processeur :** Intel i5 ou équivalent AMD

## 🛠️ Phase 1 : Configuration de l'environnement (Semaine 1)

### 1.1 Installation Flutter SDK

#### Windows
```powershell
# 1. Télécharger Flutter SDK depuis https://flutter.dev/docs/get-started/install
# 2. Extraire dans C:\flutter
# 3. Ajouter C:\flutter\bin au PATH système

# Vérification
flutter doctor
```

#### macOS
```bash
# Via Homebrew (recommandé)
brew install flutter

# Ou téléchargement manuel
# https://flutter.dev/docs/get-started/install/macos
```

#### Linux
```bash
# Télécharger et extraire Flutter
wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.0-stable.tar.xz
tar xf flutter_linux_3.22.0-stable.tar.xz

# Ajouter au PATH
echo 'export PATH="$PATH:`pwd`/flutter/bin"' >> ~/.bashrc
source ~/.bashrc
```

### 1.2 Configuration des outils de développement

#### Android Studio (Recommandé)
```bash
# 1. Installer Android Studio
# 2. Installer Android SDK (API 34 minimum)
# 3. Configurer AVD Manager pour émulateurs
# 4. Installer plugins Flutter et Dart

flutter doctor --android-licenses  # Accepter les licences
```

#### VS Code (Alternative légère)
```bash
# Extensions nécessaires :
# - Flutter
# - Dart
# - Flutter Widget Snippets
# - Awesome Flutter Snippets
```

#### Xcode (macOS uniquement pour iOS)
```bash
# Installer depuis Mac App Store
# Configurer Command Line Tools
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### 1.3 Vérification de l'installation
```bash
flutter doctor -v
# Toutes les coches doivent être vertes sauf Xcode (si pas sur macOS)
```

### 1.4 Configuration des émulateurs

#### Android Emulator
```bash
# Depuis Android Studio :
# Tools > AVD Manager > Create Virtual Device
# Choisir : Pixel 7 (API 34) avec Google Play Store
```

#### iOS Simulator (macOS uniquement)
```bash
open -a Simulator
```

#### Émulateurs Web
```bash
flutter config --enable-web
```

## 🏗️ Phase 2 : Initialisation du projet (Semaine 1)

### 2.1 Création du projet
```bash
# Naviguer vers le dossier de travail
cd "C:\Users\jorda\Documents\Jordan\cursor\00-App Mobile Flutter Test"

# Créer le projet Flutter
flutter create --org com.sandbox.toolbox toolbox_sandbox_app
cd toolbox_sandbox_app

# Test de fonctionnement
flutter run
```

### 2.2 Configuration initiale

#### pubspec.yaml
```yaml
name: toolbox_sandbox_app
description: Application bac à sable pour apprentissage Flutter
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: ">=3.22.0"

dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_riverpod: ^2.6.1
  riverpod_annotation: ^2.3.5
  
  # Navigation
  go_router: ^14.0.0
  
  # Storage & Data
  shared_preferences: ^2.2.0
  sqflite: ^2.3.0
  path_provider: ^2.1.1
  
  # Network
  http: ^1.1.0
  dio: ^5.4.0
  connectivity_plus: ^5.0.2
  
  # UI & Animations
  flutter_animate: ^4.5.0
  lottie: ^3.1.0
  cached_network_image: ^3.3.1
  
  # Permissions & Device
  permission_handler: ^11.0.0
  device_info_plus: ^9.1.1
  package_info_plus: ^4.2.0
  
  # Location
  geolocator: ^10.1.0
  geocoding: ^2.1.1
  google_maps_flutter: ^2.5.0
  
  # Files & Storage
  file_picker: ^6.1.1
  path: ^1.8.3
  open_file: ^3.3.2
  
  # Sharing & Communication
  share_plus: ^7.2.1
  url_launcher: ^6.2.2
  
  # Audio & Speech
  speech_to_text: ^6.6.0
  flutter_tts: ^3.8.5
  audioplayers: ^5.2.1
  record: ^5.0.4
  
  # Sensors & Hardware
  sensors_plus: ^4.0.2
  camera: ^0.10.5
  image_picker: ^1.0.5
  vibration: ^1.8.4
  torch_light: ^1.0.0
  
  # Bluetooth (Android principalement)
  flutter_bluetooth_serial: ^0.4.0
  
  # Utilities
  intl: ^0.19.0
  uuid: ^4.2.1
  crypto: ^3.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
  
  # Code Generation
  riverpod_generator: ^2.3.11
  build_runner: ^2.4.7
  json_annotation: ^4.8.1
  json_serializable: ^6.7.1
  
  # Testing
  mockito: ^5.4.4
  integration_test:
    sdk: flutter

flutter:
  uses-material-design: true
  
  assets:
    - assets/images/
    - assets/icons/
    - assets/animations/
    - assets/sounds/
  
  fonts:
    - family: Roboto
      fonts:
        - asset: fonts/Roboto-Regular.ttf
        - asset: fonts/Roboto-Bold.ttf
          weight: 700
```

### 2.3 Configuration des permissions

#### android/app/src/main/AndroidManifest.xml
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Permissions Internet -->
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
    
    <!-- Permissions Location -->
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    
    <!-- Permissions Storage -->
    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
    <uses-permission android:name="android.permission.MANAGE_EXTERNAL_STORAGE" />
    
    <!-- Permissions Audio -->
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    
    <!-- Permissions Camera -->
    <uses-permission android:name="android.permission.CAMERA" />
    
    <!-- Permissions Bluetooth -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
    
    <!-- Permissions Sensors -->
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.FLASHLIGHT" />
    
    <application
        android:label="Toolbox Sandbox"
        android:name="${applicationName}"
        android:icon="@mipmap/ic_launcher">
        <!-- Configuration Google Maps API -->
        <meta-data android:name="com.google.android.geo.API_KEY"
                   android:value="YOUR_GOOGLE_MAPS_API_KEY"/>
        
        <activity
            android:name=".MainActivity"
            android:exported="true"
            android:launchMode="singleTop"
            android:theme="@style/LaunchTheme"
            android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
            android:hardwareAccelerated="true"
            android:windowSoftInputMode="adjustResize">
            
            <meta-data
              android:name="io.flutter.embedding.android.NormalTheme"
              android:resource="@style/NormalTheme" />
            
            <intent-filter android:autoVerify="true">
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        
        <meta-data
            android:name="flutterEmbedding"
            android:value="2" />
    </application>
</manifest>
```

#### ios/Runner/Info.plist (pour iOS)
```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>Cette app utilise la localisation pour les fonctionnalités de géolocalisation.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>Cette app utilise la localisation pour les fonctionnalités de géolocalisation.</string>
<key>NSCameraUsageDescription</key>
<string>Cette app utilise la caméra pour prendre des photos.</string>
<key>NSMicrophoneUsageDescription</key>
<string>Cette app utilise le microphone pour l'enregistrement audio.</string>
<key>NSBluetoothAlwaysUsageDescription</key>
<string>Cette app utilise Bluetooth pour se connecter aux appareils.</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Cette app accède à la galerie photo pour sélectionner des images.</string>
```

## 🏛️ Phase 3 : Architecture du projet (Semaine 1-2)

### 3.1 Structure des dossiers
```
lib/
├── core/                           # Configuration globale
│   ├── constants/
│   │   ├── app_constants.dart      # Constantes application
│   │   ├── api_constants.dart      # URLs et endpoints
│   │   └── asset_constants.dart    # Chemins assets
│   ├── theme/
│   │   ├── app_theme.dart          # Thème principal
│   │   ├── app_colors.dart         # Palette couleurs
│   │   └── app_text_styles.dart    # Styles de texte
│   ├── utils/
│   │   ├── app_utils.dart          # Utilitaires généraux
│   │   ├── validators.dart         # Validateurs formulaires
│   │   └── formatters.dart         # Formatters de données
│   ├── widgets/
│   │   ├── custom_app_bar.dart     # AppBar personnalisé
│   │   ├── loading_widget.dart     # Widget de chargement
│   │   └── error_widget.dart       # Widget d'erreur
│   ├── services/
│   │   ├── permission_service.dart # Gestion permissions
│   │   ├── storage_service.dart    # Stockage local
│   │   └── notification_service.dart # Notifications
│   └── router/
│       └── app_router.dart         # Configuration routing
│
├── features/                       # Modules fonctionnels
│   ├── home/                       # Page d'accueil
│   │   ├── data/
│   │   │   └── home_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── home_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── feature_card.dart
│   │   │   │   └── navigation_drawer.dart
│   │   │   └── controllers/
│   │   │       └── home_controller.dart
│   │   └── domain/
│   │       └── models/
│   │           └── feature_item.dart
│   │
│   ├── calculator/                 # Module calculatrice
│   │   ├── data/
│   │   │   └── calculator_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── calculator_screen.dart
│   │   │   │   └── converter_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── calculator_button.dart
│   │   │   │   └── history_list.dart
│   │   │   └── controllers/
│   │   │       └── calculator_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   └── calculation.dart
│   │       └── usecases/
│   │           └── perform_calculation.dart
│   │
│   ├── location/                   # Module géolocalisation
│   │   ├── data/
│   │   │   ├── location_repository.dart
│   │   │   └── models/
│   │   │       └── location_dto.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── location_screen.dart
│   │   │   │   └── maps_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── location_card.dart
│   │   │   │   └── maps_widget.dart
│   │   │   └── controllers/
│   │   │       └── location_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   └── location.dart
│   │       └── usecases/
│   │           ├── get_current_location.dart
│   │           └── calculate_distance.dart
│   │
│   ├── files/                      # Module gestion fichiers
│   │   ├── data/
│   │   │   └── file_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── file_manager_screen.dart
│   │   │   │   └── file_viewer_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── file_list_item.dart
│   │   │   │   └── file_picker_widget.dart
│   │   │   └── controllers/
│   │   │       └── file_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   └── file_item.dart
│   │       └── usecases/
│   │           ├── read_file.dart
│   │           └── write_file.dart
│   │
│   ├── network/                    # Module communication serveur
│   │   ├── data/
│   │   │   ├── api_client.dart
│   │   │   └── network_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── api_test_screen.dart
│   │   │   │   └── download_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── api_response_widget.dart
│   │   │   │   └── download_progress.dart
│   │   │   └── controllers/
│   │   │       └── network_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   ├── api_response.dart
│   │       │   └── download_item.dart
│   │       └── usecases/
│   │           ├── fetch_data.dart
│   │           └── download_file.dart
│   │
│   ├── audio/                      # Module audio et voix
│   │   ├── data/
│   │   │   └── audio_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   ├── speech_screen.dart
│   │   │   │   └── audio_recorder_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── voice_visualizer.dart
│   │   │   │   └── audio_controls.dart
│   │   │   └── controllers/
│   │   │       └── audio_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   ├── speech_result.dart
│   │       │   └── audio_recording.dart
│   │       └── usecases/
│   │           ├── speech_to_text.dart
│   │           └── text_to_speech.dart
│   │
│   ├── sharing/                    # Module partage social
│   │   ├── data/
│   │   │   └── sharing_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── sharing_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── share_options.dart
│   │   │   │   └── qr_generator.dart
│   │   │   └── controllers/
│   │   │       └── sharing_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   └── share_content.dart
│   │       └── usecases/
│   │           └── share_content.dart
│   │
│   ├── bluetooth/                  # Module Bluetooth
│   │   ├── data/
│   │   │   └── bluetooth_repository.dart
│   │   ├── presentation/
│   │   │   ├── screens/
│   │   │   │   └── bluetooth_screen.dart
│   │   │   ├── widgets/
│   │   │   │   ├── device_list.dart
│   │   │   │   └── connection_status.dart
│   │   │   └── controllers/
│   │   │       └── bluetooth_controller.dart
│   │   └── domain/
│   │       ├── models/
│   │       │   └── bluetooth_device.dart
│   │       └── usecases/
│   │           ├── scan_devices.dart
│   │           └── connect_device.dart
│   │
│   └── sensors/                    # Module capteurs
│       ├── data/
│       │   └── sensors_repository.dart
│       ├── presentation/
│       │   ├── screens/
│       │   │   └── sensors_screen.dart
│       │   ├── widgets/
│       │   │   ├── sensor_display.dart
│       │   │   └── camera_preview.dart
│       │   └── controllers/
│       │       └── sensors_controller.dart
│       └── domain/
│           ├── models/
│           │   └── sensor_data.dart
│           └── usecases/
│               └── read_sensors.dart
│
├── shared/                         # Composants partagés
│   ├── models/
│   │   ├── app_error.dart          # Modèle d'erreur global
│   │   └── result.dart             # Wrapper Result<T>
│   ├── services/
│   │   ├── api_service.dart        # Service API global
│   │   ├── cache_service.dart      # Service de cache
│   │   └── logger_service.dart     # Service de logging
│   ├── providers/
│   │   ├── app_providers.dart      # Providers globaux
│   │   └── connectivity_provider.dart # Provider connectivité
│   └── widgets/
│       ├── custom_button.dart      # Bouton personnalisé
│       ├── custom_text_field.dart  # Champ texte personnalisé
│       └── animated_fab.dart       # FAB animé
│
├── l10n/                           # Localisation
│   ├── app_en.arb                  # Anglais
│   └── app_fr.arb                  # Français
│
└── main.dart                       # Point d'entrée
```

## 🔧 Phase 4 : Développement par modules (Semaines 2-8)

### 4.1 Ordre de développement recommandé

#### ✅ Semaine 1-2 : Foundation (TERMINÉ)
1. **✅ Configuration du thème et navigation**
   - ✅ Thème Material 3 bleu moderne
   - ✅ Navigation entre modules fonctionnelle
   - ✅ Interface responsive multi-plateforme

2. **✅ Page d'accueil**
   - ✅ Grille 2x4 de fonctionnalités colorées
   - ✅ Navigation vers modules avec cartes cliquables
   - ✅ Interface moderne avec message de bienvenue

#### ✅ Semaine 2-3 : Premier Module (TERMINÉ)
1. **✅ Module Calculatrice**
   - ✅ Calculatrice complète avec interface professionnelle
   - ✅ Opérations de base (+, -, ×, ÷, %)
   - ✅ Gestion décimales, Clear et Delete
   - ✅ Affichage expression et résultat
   - ⏳ Historique des calculs (futur)
   - ⏳ Convertisseurs d'unités (futur)

#### 🎯 Semaine 3-4 : Modules Core (EN COURS)
1. **🔄 Module Gestion de fichiers**
   - Explorateur de fichiers système
   - Lecture/écriture de fichiers
   - Sélecteur de fichiers natif
1. **Module Capteurs**
   - Accéléromètre et gyroscope
   - Caméra et photos
   - Contrôle de la lampe torche

2. **Module Bluetooth** (optionnel)
   - Scan d'appareils
   - Connexion et échange de données

#### Semaines 7-8 : Tests et optimisation
1. **Tests complets**
   - Tests unitaires
   - Tests d'intégration
   - Tests sur devices physiques

2. **Optimisation et documentation**
   - Performance tuning
   - Documentation du code
   - Guide utilisateur

### 4.2 Commandes de développement utiles

#### Tests
```bash
# Tests unitaires
flutter test

# Tests avec coverage
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# Tests d'intégration
flutter drive --target=test_driver/app.dart

# Tests sur device
flutter test integration_test/
```

#### Build et déploiement
```bash
# Debug build
flutter run --debug

# Release build Android
flutter build apk --release
flutter build appbundle --release

# Release build iOS
flutter build ios --release

# Build web
flutter build web --release
```

#### Outils de développement
```bash
# Analyse du code
flutter analyze

# Formatage du code
dart format lib/

# Génération de code
flutter packages pub run build_runner build

# Nettoyage
flutter clean
flutter pub get
```

## 📱 Phase 5 : Tests et débogage

### 5.1 Stratégie de tests

#### Tests unitaires (lib/test/)
```dart
// Exemple de test pour calculatrice
test('should perform addition correctly', () {
  final calculator = Calculator();
  final result = calculator.add(2, 3);
  expect(result, equals(5));
});
```

#### Tests de widgets
```dart
// Exemple de test widget
testWidgets('Calculator button should display correct text', (tester) async {
  await tester.pumpWidget(MaterialApp(
    home: CalculatorButton(text: '1', onPressed: () {}),
  ));
  
  expect(find.text('1'), findsOneWidget);
});
```

#### Tests d'intégration
```dart
// Test de flow complet
testWidgets('Complete calculator flow test', (tester) async {
  await tester.pumpWidget(MyApp());
  
  // Navigation vers calculatrice
  await tester.tap(find.text('Calculatrice'));
  await tester.pumpAndSettle();
  
  // Effectuer calcul
  await tester.tap(find.text('2'));
  await tester.tap(find.text('+'));
  await tester.tap(find.text('3'));
  await tester.tap(find.text('='));
  
  // Vérifier résultat
  expect(find.text('5'), findsOneWidget);
});
```

### 5.2 Outils de débogage

#### Flutter Inspector
- Inspection de l'arbre de widgets
- Analyse des performances
- Détection des rebuilds inutiles

#### Debugging sur device
```bash
# Connexion USB debugging
flutter devices
flutter run -d <device_id>

# Debugging sans fil
flutter run --host 0.0.0.0 --port 8080
```

## 📚 Phase 6 : Documentation et déploiement

### 6.1 Documentation du code
```dart
/// Service pour gérer les fonctionnalités de géolocalisation
/// 
/// Exemple d'utilisation :
/// ```dart
/// final location = await LocationService().getCurrentPosition();
/// print('Latitude: ${location.latitude}');
/// ```
class LocationService {
  /// Obtient la position GPS actuelle de l'utilisateur
  /// 
  /// Retourne [Position] avec latitude et longitude
  /// Lance [LocationException] si permission refusée
  Future<Position> getCurrentPosition() async {
    // Implementation...
  }
}
```

### 6.2 Déploiement

#### Android (Google Play Store)
1. Configurer signing key
2. Optimiser l'APK/AAB
3. Préparer les screenshots et descriptions
4. Upload sur Play Console

#### iOS (App Store)
1. Configurer provisioning profiles
2. Build avec Xcode
3. Upload vers App Store Connect
4. Soumission pour review

## 🎯 Métriques de succès et livrables

### Livrables finaux
- ✅ Application fonctionnelle multi-plateforme
- ✅ Code source avec architecture clean
- ✅ Tests unitaires et d'intégration
- ✅ Documentation technique complète
- ✅ Guide d'installation et d'utilisation

### Critères de réussite
- Application stable sans crash
- Interface responsive et intuitive
- Toutes les fonctionnalités opérationnelles
- Tests avec couverture > 80%
- Performance fluide (60fps)

## 🚨 Points d'attention et bonnes pratiques

### Sécurité
- Validation des entrées utilisateur
- Gestion sécurisée des permissions
- Chiffrement des données sensibles
- Authentification pour APIs

### Performance
- Lazy loading des modules
- Optimisation des images
- Gestion mémoire efficace
- Cache intelligent des données

### Maintenance
- Code modulaire et testable
- Documentation à jour
- Versioning sémantique
- CI/CD pipeline

---

Ce plan vous guidera étape par étape dans la création de votre application Flutter. Chaque phase peut être adaptée selon votre rythme d'apprentissage et vos priorités. N'hésitez pas à poser des questions à chaque étape !
