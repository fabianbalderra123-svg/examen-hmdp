# 🚀 Refaccionaria - App Móvil para Clientes

Sistema de refaccionaria con app móvil para clientes.

## 📱 ¿Qué es este proyecto?

Este repositorio contiene:
- **Backend** (Node.js + Prisma + PostgreSQL) - Sistema administrativo
- **Frontend** (Vite + React) - Panel administrativo web
- **App Móvil** (Flutter) - App para clientes de la refaccionaria ⭐ **NUEVO**

## 🎯 App Móvil - Características

- ✅ Registro y login de clientes
- ✅ Catálogo de refacciones con búsqueda
- ✅ Sistema de apartados (reservar piezas para recoger)
- ✅ GPS: ubicación de la sucursal y navegación
- ✅ Soporte offline con base de datos local
- ✅ Sincronización automática

## 🚀 Inicio Rápido para el Usuario con Flutter

Si ya tienes Flutter instalado, sigue estos 3 pasos:

### 1. Clonar y Cambiar de Rama

```bash
git clone https://github.com/cloud-david/examen1-herramientas.git
cd examen1-herramientas
git checkout feature/mobile-app
```

### 2. Configurar la App Móvil

```bash
cd mobile
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Ejecutar

```bash
flutter run
```

## 📚 Documentación

- **[COMPARTIR_PROYECTO.md](COMPARTIR_PROYECTO.md)** - Guía rápida para compartir
- **[INSTRUCCIONES_PARA_OTRO_USUARIO.md](INSTRUCCIONES_PARA_OTRO_USUARIO.md)** - Instrucciones detalladas
- **[ENDPOINTS_NUEVOS.md](ENDPOINTS_NUEVOS.md)** - Documentación de endpoints del backend
- **[mobile/README.md](mobile/README.md)** - README específico de la app móvil

## 🔧 Backend

El backend está desplegado y funcionando en:
- https://refaccionaria-api-qon3.onrender.com

La app móvil está configurada para usar este backend automáticamente en producción.

## ✅ Checklist

- [ ] Flutter instalado
- [ ] Clonar repositorio
- [ ] Checkout a rama `feature/mobile-app`
- [ ] Instalar dependencias de Flutter
- [ ] Ejecutar build_runner
- [ ] Ejecutar la app

## 🐛 Problemas

Ver [INSTRUCCIONES_PARA_OTRO_USUARIO.md](INSTRUCCIONES_PARA_OTRO_USUARIO.md) para solución de problemas comunes.
