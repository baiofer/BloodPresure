# BloodPressure - Monitor de Tensión Arterial

Aplicación móvil iOS para el control y monitoreo de la tensión arterial.

## Características

- **Autenticación de Usuario**: Sistema de login y registro con usuario y contraseña
- **Registro de Presión**: 
  - Introducción de 3 lecturas (Sistólica, Diastólica y Pulso)
  - Registro automático de hora para cada lectura
  - Cálculo automático de la media de las 3 lecturas
  - Almacenamiento de la media junto con fecha y hora
- **TabBar con 4 opciones**:
  1. **Registrar**: Pantalla para introducir las 3 lecturas de presión arterial
  2. **Historial**: Lista completa de todas las lecturas guardadas
  3. **Estadísticas**: Promedios generales y resumen de datos
  4. **Ajustes**: Configuración de usuario y guía de valores

## Estructura del Proyecto

```
BloodPressure/
├── BloodPressureApp.swift         # Punto de entrada de la aplicación
├── Models/
│   ├── User.swift                 # Modelo de usuario
│   └── BloodPressureReading.swift # Modelo de lectura de presión
├── Views/
│   ├── LoginView.swift            # Vista de inicio de sesión
│   ├── RegisterView.swift         # Vista de registro
│   ├── MainTabView.swift          # TabBar principal
│   ├── ReadingInputView.swift     # Vista de entrada de lecturas
│   ├── HistoryView.swift          # Vista del historial
│   ├── StatisticsView.swift       # Vista de estadísticas
│   └── SettingsView.swift         # Vista de ajustes
├── ViewModels/
│   └── ReadingViewModel.swift     # ViewModel para lecturas
└── Services/
    ├── AuthenticationService.swift # Servicio de autenticación
    └── DataService.swift           # Servicio de persistencia de datos
```

## Requisitos

- iOS 15.0 o superior
- Xcode 14.0 o superior
- Swift 5.9 o superior

## Cómo Usar

### Para abrir en Xcode:

1. Clonar el repositorio
2. Abrir el archivo `BloodPressure/BloodPressureApp.swift` en Xcode
3. Seleccionar un simulador iOS o dispositivo
4. Ejecutar el proyecto (⌘ + R)

### Flujo de la Aplicación:

1. **Registro/Login**: 
   - Crear una cuenta nueva con usuario y contraseña
   - O iniciar sesión con credenciales existentes

2. **Registrar Lecturas**:
   - Ir a la pestaña "Registrar"
   - Introducir 3 lecturas con valores de Sistólica, Diastólica y Pulso
   - Cada lectura registra automáticamente la hora
   - Presionar "Guardar Media" para calcular y guardar el promedio

3. **Ver Historial**:
   - Ir a la pestaña "Historial"
   - Ver todas las lecturas guardadas con códigos de color según los valores
   - Deslizar para eliminar lecturas

4. **Ver Estadísticas**:
   - Ir a la pestaña "Estadísticas"
   - Ver promedios generales de todos los parámetros
   - Revisar el número total de lecturas

5. **Configuración**:
   - Ir a la pestaña "Ajustes"
   - Ver información de usuario
   - Consultar la guía de valores recomendados
   - Cerrar sesión

## Guía de Valores

### Presión Arterial Normal:
- **Sistólica**: < 120 mmHg (Verde)
- **Diastólica**: < 80 mmHg (Verde)

### Presión Arterial Elevada:
- **Sistólica**: 120-139 mmHg (Naranja)
- **Diastólica**: 80-89 mmHg (Naranja)

### Presión Arterial Alta:
- **Sistólica**: ≥ 140 mmHg (Rojo)
- **Diastólica**: ≥ 90 mmHg (Rojo)

## Tecnologías Utilizadas

- SwiftUI para la interfaz de usuario
- UserDefaults para persistencia de datos
- Combine framework para la gestión de estado
- MVVM (Model-View-ViewModel) como patrón de arquitectura

## Notas

Esta aplicación almacena los datos localmente en el dispositivo usando UserDefaults. Los datos permanecen en el dispositivo incluso después de cerrar la aplicación.
