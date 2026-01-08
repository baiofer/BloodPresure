# Instrucciones para Abrir el Proyecto en Xcode

Este proyecto es una aplicación SwiftUI para iOS que actualmente está estructurada como código fuente. Para ejecutarla en Xcode, sigue estos pasos:

## Opción 1: Crear un Nuevo Proyecto en Xcode (Recomendado)

1. **Abrir Xcode** (versión 14.0 o superior)

2. **Crear un nuevo proyecto**:
   - File → New → Project
   - Seleccionar iOS → App
   - Click "Next"

3. **Configurar el proyecto**:
   - Product Name: `BloodPressure`
   - Team: Seleccionar tu equipo de desarrollo
   - Organization Identifier: `com.tuorganizacion`
   - Interface: SwiftUI
   - Language: Swift
   - Storage: None (usamos UserDefaults)
   - Click "Next"

4. **Guardar el proyecto**:
   - Guardar en una ubicación temporal (no en este repositorio)

5. **Reemplazar los archivos**:
   - Eliminar el archivo `ContentView.swift` que Xcode creó por defecto
   - Eliminar el archivo predeterminado `BloodPressureApp.swift` de Xcode
   - Arrastrar todos los archivos y carpetas de este repositorio al proyecto de Xcode:
     - `BloodPressure/BloodPressureApp.swift`
     - `BloodPressure/Models/`
     - `BloodPressure/Views/`
     - `BloodPressure/ViewModels/`
     - `BloodPressure/Services/`
   - Asegúrate de seleccionar "Copy items if needed"

6. **Configurar Assets**:
   - Eliminar el Assets.xcassets por defecto si es necesario
   - Copiar o usar el Assets.xcassets de este repositorio

7. **Ejecutar**:
   - Seleccionar un simulador (iPhone 14 Pro recomendado)
   - Click en el botón Play o presionar ⌘ + R

## Opción 2: Usar Swift Package Manager (Alternativo)

1. Abrir Terminal en la carpeta del proyecto
2. Ejecutar: `swift build` (para verificar que compila)
3. Para crear un proyecto Xcode:
   ```bash
   swift package generate-xcodeproj
   ```
4. Abrir el archivo `.xcodeproj` generado
5. Configurar el target para iOS
6. Ejecutar el proyecto

## Opción 3: Abrir como Swift Package

1. En Xcode: File → Open
2. Seleccionar la carpeta del repositorio
3. Xcode debería reconocer el Package.swift
4. Nota: Puede que necesites configurar un scheme de ejecución

## Estructura de Archivos Esperada en Xcode

```
BloodPressure (Grupo/Carpeta)
├── BloodPressureApp.swift
├── Models
│   ├── User.swift
│   └── BloodPressureReading.swift
├── Views
│   ├── LoginView.swift
│   ├── RegisterView.swift
│   ├── MainTabView.swift
│   ├── ReadingInputView.swift
│   ├── HistoryView.swift
│   ├── StatisticsView.swift
│   └── SettingsView.swift
├── ViewModels
│   └── ReadingViewModel.swift
├── Services
│   ├── AuthenticationService.swift
│   └── DataService.swift
├── Assets.xcassets
│   ├── AccentColor.colorset
│   └── AppIcon.appiconset
└── Info.plist
```

## Requisitos del Sistema

- macOS 12.0 (Monterey) o superior
- Xcode 14.0 o superior
- iOS 15.0 o superior (para ejecutar en simulador o dispositivo)

## Solución de Problemas

### Error: "Cannot find 'X' in scope"
- Asegúrate de que todos los archivos están añadidos al target de la app
- Verifica que no hay errores de importación

### Error de compilación
- Limpiar el build: Product → Clean Build Folder (⇧⌘K)
- Cerrar y reabrir Xcode

### Simulador no aparece
- Xcode → Settings → Platforms
- Descargar el runtime de iOS 15.0 o superior

### App no se ejecuta
- Verificar que el target está configurado para iOS
- Verificar que el deployment target es iOS 15.0 o superior

## Próximos Pasos Después de Abrir

1. **Probar el flujo de registro**:
   - Crear un nuevo usuario
   - Iniciar sesión

2. **Registrar lecturas**:
   - Ir a la pestaña "Registrar"
   - Introducir 3 lecturas de prueba
   - Guardar la media

3. **Explorar otras pestañas**:
   - Ver el historial de lecturas
   - Revisar estadísticas
   - Explorar la configuración

## Notas Adicionales

- La aplicación usa UserDefaults para persistencia, por lo que los datos se mantienen entre ejecuciones
- Para resetear la app completamente, borra la app del simulador
- El código está en español para coincidir con la interfaz de usuario
- Todos los archivos siguen las convenciones de Swift y SwiftUI

## Contacto y Soporte

Si tienes problemas para abrir el proyecto, revisa:
1. Que Xcode esté actualizado
2. Que tengas los simuladores de iOS instalados
3. La documentación en DEVELOPMENT.md

¡Disfruta desarrollando la aplicación de monitoreo de presión arterial!
