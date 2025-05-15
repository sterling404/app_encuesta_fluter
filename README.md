# Aplicación Flutter - Proyecto VCM "Video del Jueves"

Esta aplicación móvil desarrollada en Flutter presenta contenido audiovisual académico, registra respuestas del usuario y otorga retroalimentación motivacional en formato de insignias. El propósito es reforzar contenidos relacionados con los proyectos de Vinculación con el Medio (VCM) de la Universidad Adventista de Chile.

## Descripción del Proyecto

La aplicación consta de cuatro pantallas principales:

1. **Pantalla de Inicio**: Muestra información sobre el propósito de la encuesta y la autorización para uso de datos.
2. **Pantalla de Video**: Reproduce un video académico sobre proyectos VCM con controles básicos.
3. **Pantalla de Encuesta**: Permite al usuario responder tres preguntas relacionadas con proyectos VCM.
4. **Pantalla Final**: Muestra una felicitación con insignia al completar la encuesta.

## Tecnologías Utilizadas

- Flutter
- Firebase Firestore (para almacenamiento de respuestas)
- Paquetes: firebase_core, cloud_firestore, device_info_plus, video_player, flutter_svg

## Capturas de Pantalla

### Pantalla de Inicio
![Pantalla de Inicio](screenshots/home_screen.png)

### Pantalla de Video
![Pantalla de Video](screenshots/video_screen.png)

### Pantalla de Encuesta
![Pantalla de Encuesta](screenshots/survey_screen.png)

### Pantalla de Insignia
![Pantalla de Insignia](screenshots/badge_screen.png)

## Requisitos Previos

Para ejecutar esta aplicación necesitas:

- Flutter SDK 3.0.0 o superior
- Dart 2.18.0 o superior
- Una cuenta en Firebase
- Android Studio / VS Code

## Instrucciones de Compilación

1. **Clonar el repositorio**:
   ```
   git clone [URL_DEL_REPOSITORIO]
   cd app_encuesta_fluter
   ```

2. **Instalar dependencias**:
   ```
   flutter pub get
   ```

3. **Configurar Firebase**:
   - Crea un proyecto en Firebase Console
   - Agrega la aplicación Android/iOS al proyecto de Firebase
   - Descarga los archivos de configuración (google-services.json para Android, GoogleService-Info.plist para iOS)
   - Coloca los archivos en las ubicaciones correspondientes:
     - Android: `/android/app/google-services.json`
     - iOS: `/ios/Runner/GoogleService-Info.plist`

4. **Ejecutar la aplicación**:
   ```
   flutter run
   ```

## Estructura del Proyecto

```
lib/
├── main.dart                  # Punto de entrada de la aplicación
├── screens/
│   ├── home_screen.dart       # Pantalla de inicio/autorización
│   ├── video_screen.dart      # Pantalla de reproducción de video
│   ├── survey_screen.dart     # Pantalla de formulario de encuesta
│   └── badge_screen.dart      # Pantalla de insignia/reconocimiento
└── widgets/
    └── bottom_nav_bar.dart    # Barra de navegación inferior
```

## Notas Importantes

- Asegúrate de tener un archivo de video en `assets/videos/sample_video.mp4`
- La aplicación guarda las respuestas en Firestore junto con información del dispositivo
- El botón "Ir a encuesta" solo está disponible después de ver el video completo

## Autor

[Tu Nombre] - Desarrollo Móvil Multiplataforma, UNACH 2025