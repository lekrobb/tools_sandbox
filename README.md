# Toolbox Sandbox App

Application mobile Flutter "bac à sable" pour l'apprentissage du développement mobile et l'exploration des fonctionnalités natives des appareils.

## 📱 Description

Cette application a été conçue comme un laboratoire d'apprentissage pour découvrir et maîtriser :
- Les fonctionnalités natives des smartphones (GPS, caméra, capteurs, etc.)
- L'écosystème Flutter et les bonnes pratiques de développement
- L'architecture mobile moderne avec clean architecture
- L'intégration d'APIs et services externes

## 🚀 Fonctionnalités

### 🔢 Calculatrice
- Calculatrice scientifique complète
- Historique des calculs
- Convertisseur d'unités

### 📍 Géolocalisation
- Position GPS en temps réel
- Cartes interactives
- Calcul de distances
- Historique des positions

### 📁 Gestion de fichiers
- Explorateur de fichiers système
- Opérations de base (copie, déplacement, suppression)
- Prévisualisation de fichiers
- Import/export de données

### 🌐 Communication réseau
- Client HTTP pour tests d'API
- Téléchargement de fichiers
- Gestion du cache et mode hors ligne
- WebSocket pour temps réel

### 🎤 Audio & Reconnaissance vocale
- Speech-to-Text (reconnaissance vocale)
- Text-to-Speech (synthèse vocale)
- Enregistrement audio
- Commandes vocales personnalisées

### 📤 Partage social
- Partage vers applications natives
- Génération de QR codes
- Partage de fichiers multiples
- Intégration réseaux sociaux

### 📱 Capteurs & Hardware
- Accéléromètre et gyroscope
- Contrôle de la caméra
- Lampe torche
- Vibrations personnalisées

### 🔵 Bluetooth (en développement)
- Scan d'appareils
- Connexion et échange de données
- Gestion des appareils appairés

## 🏗️ Architecture

Le projet suit les principes de **Clean Architecture** avec une organisation modulaire :

```
lib/
├── core/                 # Configuration globale
│   ├── constants/        # Constantes
│   ├── theme/           # Thèmes et styles
│   ├── utils/           # Utilitaires
│   ├── widgets/         # Widgets réutilisables
│   └── router/          # Configuration navigation
├── features/            # Modules fonctionnels
│   ├── home/           # Page d'accueil
│   ├── calculator/     # Module calculatrice
│   ├── location/       # Module géolocalisation
│   ├── files/          # Module fichiers
│   ├── network/        # Module réseau
│   ├── audio/          # Module audio
│   ├── sharing/        # Module partage
│   ├── bluetooth/      # Module Bluetooth
│   └── sensors/        # Module capteurs
└── shared/             # Composants partagés
    ├── models/         # Modèles globaux
    ├── services/       # Services
    └── providers/      # Providers Riverpod
```

Chaque feature suit le pattern :
- **data/** : Accès aux données (API, DB, fichiers)
- **domain/** : Logique métier (entities, use cases)
- **presentation/** : Interface utilisateur (screens, widgets, controllers)

## 🛠️ Technologies utilisées

- **Flutter** 3.22.0 - Framework UI multiplateforme
- **Riverpod** 2.6.1 - Gestion d'état reactive
- **GoRouter** - Navigation déclarative
- **Material 3** - Design system moderne
- **Firebase** - Services backend (optionnel)

## 📋 Prérequis

- Flutter SDK 3.22.0+
- Dart 3.0+
- Android Studio / VS Code
- Android SDK (pour Android)
- Xcode (pour iOS, macOS uniquement)

## 🚀 Installation et lancement

1. **Cloner le projet**
```bash
git clone <repository-url>
cd toolbox_sandbox_app
```

2. **Installer les dépendances**
```bash
flutter pub get
```

3. **Vérifier la configuration**
```bash
flutter doctor
```

4. **Lancer l'application**
```bash
# Sur émulateur/simulateur
flutter run

# Sur device physique
flutter run -d <device-id>
```

## 🧪 Tests

```bash
# Tests unitaires
flutter test

# Tests avec couverture
flutter test --coverage

# Tests d'intégration
flutter test integration_test/
```

## 📱 Build de production

### Android
```bash
# APK
flutter build apk --release

# App Bundle (recommandé pour Play Store)
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

## 🔧 Configuration

### Permissions Android
Les permissions sont configurées dans `android/app/src/main/AndroidManifest.xml` :
- Localisation (GPS)
- Stockage (fichiers)
- Microphone (audio)
- Caméra
- Bluetooth
- Internet

### Permissions iOS
Les permissions sont configurées dans `ios/Runner/Info.plist` avec descriptions utilisateur.

### API Keys
Pour utiliser Google Maps, ajoutez votre clé API dans :
- Android : `android/app/src/main/AndroidManifest.xml`
- iOS : `ios/Runner/AppDelegate.swift`

## 📚 Structure d'apprentissage

### Phase 1 : Foundation
- [x] Setup environnement
- [x] Architecture de base
- [x] Navigation et thème
- [x] Page d'accueil

### Phase 2 : Core Features
- [x] Module calculatrice (base)
- [ ] Module gestion de fichiers
- [ ] Module communication réseau
- [ ] Module géolocalisation

### Phase 3 : Advanced Features
- [ ] Module audio et reconnaissance vocale
- [ ] Module partage social
- [ ] Module capteurs hardware
- [ ] Tests et optimisations

### Phase 4 : Polish & Extensions
- [ ] Module Bluetooth
- [ ] Tests sur devices physiques
- [ ] Documentation complète
- [ ] Optimisations performance

## 🤝 Contribution

Ce projet étant un laboratoire d'apprentissage, les contributions sont les bienvenues pour :
- Ajouter de nouvelles fonctionnalités
- Améliorer l'architecture existante
- Corriger des bugs
- Ajouter des tests
- Améliorer la documentation

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier [LICENSE](LICENSE) pour plus de détails.

## 🙋‍♂️ Support

Pour toute question ou problème :
1. Consultez la documentation dans `/docs`
2. Vérifiez les issues existantes
3. Créez une nouvelle issue si nécessaire

---

**Happy Coding! 🚀**
