# Instrucciones para Configurar el Proyecto

Este documento es para el usuario que recibirá el proyecto y ya tiene Flutter instalado.

## 📋 Requisitos Previos

- ✅ Flutter ya instalado
- ✅ Node.js y npm
- ✅ Git

## 🚀 Pasos para Configurar

### 1. Clonar el Repositorio

```bash
git clone https://github.com/cloud-david/examen1-herramientas.git
cd examen1-herramientas
```

### 2. Cambiar a la Rama de la App Móvil

```bash
git checkout feature/mobile-app
```

### 3. Configurar el Backend

#### Opción A: Usar el Backend Desplegado (RECOMENDADO)

El backend ya está funcionando en:
- URL: https://refaccionaria-api-qon3.onrender.com
- La app móvil está configurada para usar esta URL automáticamente en producción

No necesitas configurar nada adicional del backend.

#### Opción B: Ejecutar el Backend Localmente

Si prefieres ejecutar el backend localmente:

```bash
cd backend
npm install
```

Crea el archivo `.env` con las variables de entorno (ver `.env.example`):
```env
PORT=4000
DATABASE_URL="postgresql://usuario:password@localhost:5432/refaccionaria"
JWT_SECRET="tu-secreto-jwt"
JWT_EXPIRES_IN="8h"
CORS_ORIGIN="http://localhost:5173"
SEED_ADMIN_EMAIL="admin@refaccionaria.com"
SEED_ADMIN_PASSWORD="Admin123!"
```

Ejecuta las migraciones:
```bash
npx prisma migrate deploy
```

Inicia el servidor:
```bash
npm run dev
```

### 4. Configurar la App Móvil

```bash
cd mobile
```

Instala las dependencias:
```bash
flutter pub get
```

Genera el código de la base de datos local (Drift):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Ejecutar la App Móvil

#### Para Android:
```bash
flutter run
```

#### Para iOS (solo en Mac):
```bash
flutter run
```

#### Para Web (para pruebas rápidas):
```bash
flutter run -d chrome
```

### 6. Probar la App

1. Abre la app
2. Regístrate como nuevo cliente
3. Explora el catálogo de refacciones
4. Crea un apartado
5. Ver la ubicación GPS

## ⚠️ Notas Importantes

### Coordenadas de la Sucursal

Las coordenadas de la sucursal son de ejemplo. Para usar las reales:

1. Si usas el backend desplegado: Contacta al administrador para actualizar las coordenadas en el servidor
2. Si usas backend local: Edita `backend/src/controllers/sucursalController.js` y cambia:
   ```javascript
   coordenadas: {
     latitud: 19.4326,  // TODO: Cambiar a latitud real
     longitud: -99.1332, // TODO: Cambiar a longitud real
   }
   ```

### Modo Desarrollo vs Producción

La app móvil detecta automáticamente el modo:
- **Desarrollo**: Usa `http://localhost:4000`
- **Producción**: Usa `https://refaccionaria-api-qon3.onrender.com`

Para compilar en modo producción:
```bash
flutter build apk --dart-define=dart.vm.product=true
```

### Permisos de Ubicación

- **Android**: Los permisos ya están configurados en `android/app/src/main/AndroidManifest.xml`
- **iOS**: Los permisos ya están configurados en `ios/Runner/Info.plist`

## 📚 Documentación Adicional

- [Documentación de nuevos endpoints](ENDPOINTS_NUEVOS.md)
- [README del backend](backend/README.md)
- [README de la app móvil](mobile/README.md)

## 🐛 Solución de Problemas

### Error: "Could not resolve Drift"
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Error de conexión en Android
En emulador Android, usa `10.0.2.2` en lugar de `localhost` en la configuración.

### Error de permisos de ubicación
Verifica que los permisos estén configurados en:
- Android: `android/app/src/main/AndroidManifest.xml`
- iOS: `ios/Runner/Info.plist`

## ✅ Checklist

- [ ] Clonar el repositorio
- [ ] Checkout a la rama `feature/mobile-app`
- [ ] Instalar dependencias del backend (si es local)
- [ ] Instalar dependencias de Flutter
- [ ] Ejecutar build_runner para Drift
- [ ] Ejecutar la app móvil
- [ ] Probar registro de cliente
- [ ] Probar catálogo de refacciones
- [ ] Probar apartados
- [ ] Probar GPS
