# BloodPresure - Monitor de Tensión Arterial 📊

Aplicación web para registrar y monitorear tu presión arterial de forma sencilla y efectiva.

## 🚀 Cómo Lanzar la Aplicación

### Método 1: Abrir Directamente en el Navegador (Más Simple)

1. Abre el archivo `index.html` directamente en tu navegador web:
   - **Windows**: Haz doble clic en el archivo `index.html`
   - **Mac/Linux**: Haz doble clic en el archivo `index.html` o haz clic derecho y selecciona "Abrir con" → tu navegador preferido
   - **Alternativa**: Arrastra el archivo `index.html` a una ventana del navegador

### Método 2: Usar un Servidor Local (Recomendado para Desarrollo)

#### Con Python (si está instalado):
```bash
# Python 3
python -m http.server 8000

# Python 2
python -m SimpleHTTPServer 8000
```
Luego abre: http://localhost:8000

#### Con Node.js (si está instalado):
```bash
# Instalar servidor HTTP global
npm install -g http-server

# Ejecutar el servidor
http-server
```
Luego abre: http://localhost:8080

#### Con PHP (si está instalado):
```bash
php -S localhost:8000
```
Luego abre: http://localhost:8000

### Método 3: Usar Live Server en VS Code

1. Instala la extensión "Live Server" en Visual Studio Code
2. Abre el proyecto en VS Code
3. Haz clic derecho en `index.html` y selecciona "Open with Live Server"
4. La aplicación se abrirá automáticamente en tu navegador

## 📋 Características

- ✅ Registro de presión sistólica y diastólica
- ✅ Registro de pulso (opcional)
- ✅ Fecha y hora de cada medición
- ✅ Notas personalizadas para cada registro
- ✅ Categorización automática de la presión (Normal, Elevada, Hipertensión)
- ✅ Historial completo de mediciones
- ✅ Almacenamiento local (los datos se guardan en tu navegador)
- ✅ Diseño responsive (funciona en móviles y tablets)
- ✅ Interfaz en español

## 🎯 Cómo Usar

1. **Registrar una Medición**:
   - Ingresa tu presión sistólica (el número superior)
   - Ingresa tu presión diastólica (el número inferior)
   - Opcionalmente, ingresa tu pulso
   - Selecciona la fecha y hora
   - Agrega notas si lo deseas
   - Haz clic en "Guardar Medición"

2. **Ver el Historial**:
   - Todas tus mediciones aparecen en la sección "Historial de Mediciones"
   - Cada medición muestra la categoría de presión arterial

3. **Eliminar Mediciones**:
   - Haz clic en "Eliminar" en cualquier medición individual
   - Usa "Limpiar Historial" para borrar todas las mediciones

## 💡 Requisitos

- Un navegador web moderno (Chrome, Firefox, Safari, Edge)
- No requiere conexión a internet (funciona offline)
- No requiere instalación de software adicional

## ⚠️ Nota Importante

Esta aplicación es solo para seguimiento personal de tu presión arterial. **No reemplaza la consulta médica profesional**. Si tienes preocupaciones sobre tu presión arterial, consulta siempre con un médico.

## 🔒 Privacidad

Todos los datos se almacenan localmente en tu navegador usando localStorage. No se envía ninguna información a servidores externos.
