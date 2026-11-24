# Refaccionaria App - Cliente Móvil

Aplicación móvil en Flutter para clientes de la refaccionaria. Permite consultar el catálogo de refacciones, realizar apartados para recoger en tienda, y ver la ubicación de la sucursal.

## Características

- ✅ Autenticación de clientes (registro y login con JWT)
- ✅ Catálogo de refacciones con búsqueda y filtros
- ✅ Sistema de apartados (crear, historial, cancelar)
- ✅ GPS: ubicación de la sucursal, distancia y navegación
- ✅ Soporte offline con base de datos local (Drift)
- ✅ Indicador de conectividad
- ✅ Arquitectura feature-first con Riverpod
- ✅ Timeouts generosos para Render (60 segundos)

## Requisitos

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / Xcode (para desarrollo móvil)
- Backend corriendo (ver [README del backend](../backend/README.md))

## Instalación

1. Navegar a la carpeta del proyecto móvil:
```bash
cd mobile
```

2. Instalar dependencias:
```bash
flutter pub get
```

3. Generar código de Drift (base de datos local):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Configuración

### Ambiente de Desarrollo vs Producción

La URL del API se configura automáticamente según el modo de compilación:

- **Desarrollo**: `http://localhost:4000`
- **Producción**: `https://refaccionaria-api-qon3.onrender.com`

Para compilar en modo producción:
```bash
flutter build apk --dart-define=dart.vm.product=true
# o
flutter build ios --dart-define=dart.vm.product=true
```

### Coordenadas de la Sucursal

Las coordenadas de la sucursal son configurables en el backend (endpoint `/api/sucursal/config`). Actualmente están en valores de ejemplo y deben actualizarse con las coordenadas reales:

**Archivo**: `backend/src/controllers/sucursalController.js`
```javascript
coordenadas: {
  latitud: 19.4326,  // TODO: Cambiar a latitud real
  longitud: -99.1332, // TODO: Cambiar a longitud real
}
```

## Ejecución

### Android

```bash
flutter run
```

### iOS

```bash
flutter run
```

### Web (para pruebas)

```bash
flutter run -d chrome
```

## Permisos

### Android

Los permisos de ubicación ya están configurados en `android/app/src/main/AndroidManifest.xml`:
- `INTERNET`
- `ACCESS_FINE_LOCATION`
- `ACCESS_COARSE_LOCATION`

### iOS

Los permisos de ubicación están configurados en `ios/Runner/Info.plist`:
- `NSLocationWhenInUseUsageDescription`
- `NSLocationAlwaysUsageDescription`

## Arquitectura

```
lib/
├── core/
│   ├── config/          # Configuración de la app (URLs, timeouts)
│   ├── models/          # Modelos de datos (Client, Part, Apartado, Sucursal)
│   ├── providers/       # Providers globales (connectivity)
│   ├── services/        # Servicios (API, base de datos local)
│   └── utils/           # Utilidades
├── features/
│   ├── auth/            # Autenticación
│   │   ├── data/        # Repositorios
│   │   ├── domain/      # Providers de Riverpod
│   │   └── presentation/ # UI (Login, Register, Home)
│   ├── parts/           # Catálogo de refacciones
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── apartados/       # Sistema de apartados
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   └── gps/             # Ubicación y mapas
│       ├── data/
│       ├── domain/
│       └── presentation/
└── main.dart            # Punto de entrada
```

## Endpoints Consumidos

### Autenticación de Clientes

- `POST /api/client-auth/register` - Registro de cliente
- `POST /api/client-auth/login` - Login de cliente
- `GET /api/client-auth/me` - Obtener cliente autenticado

### Catálogo de Refacciones

- `GET /api/parts` - Listar refacciones (público)
- `GET /api/parts/:id` - Detalle de refacción

### Apartados

- `GET /api/apartados` - Listar apartados del cliente
- `GET /api/apartados/:id` - Detalle de apartado
- `POST /api/apartados` - Crear apartado
- `PUT /api/apartados/:id/cancelar` - Cancelar apartado

### Configuración de Sucursal

- `GET /api/sucursal/config` - Configuración de la sucursal (coordenadas, dirección, horario)

## Funcionalidad Offline

La app implementa una base de datos local con Drift para soportar modo offline:

### Catálogo Caché
- Las refacciones se cachean localmente
- Se muestra la fecha de última actualización
- El catálogo se puede consultar sin internet

### Apartados Pendientes
- Los apartados creados sin conexión se guardan como "pendientes de envío"
- Se sincronizan automáticamente al volver a tener conexión
- Implementa reintentos con backoff
- El servidor es la fuente de verdad en conflictos

### Indicador de Conectividad
- Muestra estado: en línea / sin conexión / sincronizando
- Usa `connectivity_plus` para detectar cambios de red

## Seguridad

- JWT almacenado en `flutter_secure_storage`
- Tokens de clientes tienen claim `type: "client"`
- Tokens no pueden acceder a endpoints administrativos
- Contraseñas hasheadas con bcrypt en el backend
- HTTPS en producción

## Desarrollo

### Agregar nuevas dependencias

```bash
flutter pub add nombre_del_paquete
```

### Regenerar código después de cambios en Drift

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Limpiar cache

```bash
flutter clean
flutter pub get
```

## Troubleshooting

### Error: "Could not resolve Drift"

Ejecutar:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Error de conexión en Android

Asegúrate de que el backend esté accesible. En emulador Android, usa `10.0.2.2` en lugar de `localhost`.

### Error de permisos de ubicación

Verifica que los permisos estén configurados correctamente en:
- Android: `android/app/src/main/AndroidManifest.xml`
- iOS: `ios/Runner/Info.plist`

## Documentación Adicional

- [Documentación de nuevos endpoints del backend](../ENDPOINTS_NUEVOS.md)
- [README del backend](../backend/README.md)
- [README del frontend web](../frontend/README.md)

## Licencia

Proyecto desarrollado para examen de herramientas de desarrollo.
