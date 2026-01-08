# Guía de Desarrollo - Blood Pressure Monitor

## Arquitectura de la Aplicación

### Patrón MVVM
La aplicación utiliza el patrón Model-View-ViewModel:

- **Models**: Definen la estructura de datos (User, BloodPressureReading)
- **Views**: Interfaces de usuario en SwiftUI
- **ViewModels**: Lógica de negocio y estado de la UI
- **Services**: Servicios compartidos (autenticación, persistencia)

### Flujo de Datos

1. **AuthenticationService**: Gestiona el estado de autenticación del usuario
   - Usa `@Published` para notificar cambios de autenticación
   - Persiste el usuario actual en UserDefaults

2. **DataService**: Gestiona las lecturas de presión arterial
   - Almacena y recupera lecturas de UserDefaults
   - Proporciona métodos para CRUD de lecturas

3. **ReadingViewModel**: Gestiona el estado de las 3 lecturas
   - Valida los datos introducidos
   - Calcula la media de las 3 lecturas

## Funcionalidades Principales

### 1. Sistema de Autenticación
- Registro de nuevos usuarios con validación
- Inicio de sesión con credenciales
- Persistencia de sesión
- Cierre de sesión

### 2. Registro de Lecturas
- Formulario para 3 lecturas independientes
- Cada lectura incluye: Sistólica, Diastólica y Pulso
- Registro automático de hora para cada lectura
- Validación de valores:
  - Sistólica: 0-300 mmHg
  - Diastólica: 0-200 mmHg
  - Pulso: 0-250 lpm
- Cálculo automático de media de las 3 lecturas
- Las 3 lecturas deben ser válidas para guardar

### 3. Historial
- Lista de todas las lecturas guardadas
- Ordenadas por fecha (más reciente primero)
- Códigos de color según valores:
  - Verde: valores normales
  - Naranja: valores elevados
  - Rojo: valores altos
- Función de eliminar lecturas (deslizar)

### 4. Estadísticas
- Promedios generales de todos los parámetros
- Conteo total de lecturas
- Visualización clara con iconos y colores

### 5. Configuración
- Información del usuario
- Guía de valores recomendados
- Recomendaciones para tomar lecturas correctamente
- Opción de cerrar sesión

## Persistencia de Datos

Los datos se almacenan localmente usando `UserDefaults`:

- **Usuarios**: Array de usuarios registrados
- **Usuario actual**: Usuario con sesión activa
- **Lecturas**: Array de todas las lecturas de presión arterial

### Estructura de Datos Almacenados

```swift
// Usuarios
["users": [User]]

// Usuario actual
["currentUser": User]

// Lecturas
["bloodPressureReadings": [BloodPressureReading]]
```

## Validaciones

### Registro de Usuario
- Usuario no vacío
- Contraseña no vacía
- Contraseña mínimo 4 caracteres
- Usuario único (no duplicado)
- Contraseñas coinciden

### Inicio de Sesión
- Usuario y contraseña no vacíos
- Credenciales válidas

### Lecturas de Presión
- Todas las 3 lecturas deben tener valores
- Valores numéricos válidos
- Rangos apropiados para cada parámetro

## Mejoras Futuras Posibles

1. **Gráficos**: Añadir gráficos de tendencia temporal
2. **Exportación**: Exportar datos a PDF o CSV
3. **Notificaciones**: Recordatorios para tomar lecturas
4. **iCloud**: Sincronización entre dispositivos
5. **HealthKit**: Integración con Apple Health
6. **Compartir**: Compartir lecturas con médico
7. **Medicamentos**: Registro de medicamentos tomados
8. **Notas**: Añadir notas a cada lectura
9. **Multiple Profiles**: Soporte para múltiples perfiles de usuario
10. **Dark Mode**: Optimización para modo oscuro

## Cómo Extender la Aplicación

### Añadir una nueva vista al TabBar

1. Crear nueva vista en `Views/`
2. Añadir en `MainTabView.swift`:
```swift
YourNewView()
    .environmentObject(authService)
    .environmentObject(dataService)
    .tabItem {
        Label("Tu Tab", systemImage: "icon.name")
    }
```

### Añadir un nuevo campo a las lecturas

1. Actualizar `BloodPressureReading` en `Models/`
2. Actualizar `Reading` con el nuevo campo
3. Modificar `ReadingCard` en `ReadingInputView.swift`
4. Actualizar `calculateAverage()` en `ReadingViewModel`
5. Actualizar vistas de Historial y Estadísticas

### Cambiar el almacenamiento a CoreData

1. Crear modelo de datos CoreData (.xcdatamodeld)
2. Crear entidades para User y BloodPressureReading
3. Reemplazar `DataService` con PersistenceController
4. Actualizar vistas para usar `@FetchRequest`

## Testing

Para probar la aplicación:

1. **Registro**: Crear un nuevo usuario
2. **Login**: Iniciar sesión con el usuario creado
3. **Lectura**: Añadir 3 lecturas con valores realistas:
   - Ejemplo: 120/80, 118/78, 122/82 con pulsos 70, 72, 68
4. **Verificar**: La media debería ser aproximadamente 120/80 con pulso 70
5. **Historial**: Verificar que aparece la lectura guardada
6. **Estadísticas**: Verificar los promedios
7. **Logout**: Cerrar sesión y verificar que vuelve al login

## Recursos

- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/)
- [Swift Language Guide](https://docs.swift.org/swift-book/)
- [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
