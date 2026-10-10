# Nuevos Endpoints del Backend - App Móvil de Refaccionaria

Este documento describe los nuevos endpoints agregados para soportar la aplicación móvil de clientes.

## Cambios en el Backend

### Migraciones de Base de Datos
- Agregado campo `password_hash` (opcional) a la tabla `clients`
- Agregado índice único en `clients.email`
- Nueva tabla `apartados` con los siguientes campos:
  - `id` (integer, primary key)
  - `cliente_id` (foreign key → clients)
  - `pieza_id` (foreign key → parts)
  - `cantidad` (integer)
  - `estado` (enum: PENDIENTE, CONFIRMADO, LISTO_PARA_RECOGER, ENTREGADO, CANCELADO)
  - `fecha_creacion` (timestamp)
  - `fecha_expiracion` (timestamp, nullable)
  - `nota` (text, nullable)

### Cambios en Endpoints Existentes
- `GET /api/parts` - Ahora es público (no requiere autenticación) para que la app móvil pueda acceder al catálogo

---

## Nuevos Endpoints

### Autenticación de Clientes (`/api/client-auth`)

Los clientes de la app móvil usan un sistema de autenticación separado del personal administrativo. Los tokens JWT incluyen un claim `type: "client"`.

#### POST `/api/client-auth/register`
Registro de nuevo cliente para la app móvil.

**Body:**
```json
{
  "nombre": "Juan Pérez",
  "email": "cliente@email.com",
  "password": "Password123!",
  "telefono": "+52 55 1234 5678",
  "direccion": "Calle 123, Colonia Centro"
}
```

**Response (201):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "client": {
    "id": 1,
    "nombre": "Juan Pérez",
    "email": "cliente@email.com",
    "telefono": "+52 55 1234 5678",
    "direccion": "Calle 123, Colonia Centro",
    "createdAt": "2026-10-10T12:00:00.000Z"
  }
}
```

**Validaciones:**
- `nombre`, `email`, `password` son obligatorios
- Email debe ser válido y único
- Contraseña mínimo 8 caracteres
- `telefono` y `direccion` son opcionales

---

#### POST `/api/client-auth/login`
Login de cliente existente.

**Body:**
```json
{
  "email": "cliente@email.com",
  "password": "Password123!"
}
```

**Response (200):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "client": {
    "id": 1,
    "nombre": "Juan Pérez",
    "email": "cliente@email.com",
    "telefono": "+52 55 1234 5678",
    "direccion": "Calle 123, Colonia Centro",
    "createdAt": "2026-10-10T12:00:00.000Z"
  }
}
```

---

#### GET `/api/client-auth/me`
Obtener información del cliente autenticado.

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "client": {
    "id": 1,
    "nombre": "Juan Pérez",
    "email": "cliente@email.com",
    "telefono": "+52 55 1234 5678",
    "direccion": "Calle 123, Colonia Centro",
    "createdAt": "2026-10-10T12:00:00.000Z"
  }
}
```

---

### Apartados (`/api/apartados`)

Sistema de apartados de refacciones para recoger en tienda.

#### GET `/api/apartados`
Listar apartados del cliente autenticado.

**Headers:**
```
Authorization: Bearer <token>
```

**Query Params (opcionales):**
- `page` - Número de página (default: 1)
- `pageSize` - Tamaño de página (default: 10)
- `sortBy` - Campo de ordenación: id, fechaCreacion, estado, cantidad (default: id)
- `sortOrder` - Orden: asc, desc (default: asc)

**Response (200):**
```json
{
  "items": [
    {
      "id": 1,
      "clienteId": 1,
      "piezaId": 5,
      "cantidad": 2,
      "estado": "PENDIENTE",
      "fechaCreacion": "2026-10-10T12:00:00.000Z",
      "fechaExpiracion": "2026-10-12T12:00:00.000Z",
      "nota": null,
      "pieza": {
        "id": 5,
        "codigo": "FILT-001",
        "nombre": "Filtro de Aceite",
        "descripcion": "Filtro de aceite para motor 1.6L",
        "categoria": "Filtros",
        "marca": "Bosch",
        "precioCompra": "150.00",
        "precioVenta": "250.00",
        "stock": 15,
        "stockMinimo": 5,
        "ubicacion": "A-12",
        "activo": true
      },
      "expirado": false
    }
  ],
  "total": 1,
  "page": 1,
  "pageSize": 10
}
```

**Nota:** El campo `expirado` se calcula dinámicamente basado en `fechaExpiracion`.

---

#### GET `/api/apartados/:id`
Obtener detalle de un apartado específico.

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "id": 1,
  "clienteId": 1,
  "piezaId": 5,
  "cantidad": 2,
  "estado": "PENDIENTE",
  "fechaCreacion": "2026-10-10T12:00:00.000Z",
  "fechaExpiracion": "2026-10-12T12:00:00.000Z",
  "nota": null,
  "pieza": { ... },
  "expirado": false
}
```

**Errors:**
- 404: Apartado no encontrado
- 403: No autorizado (el apartado pertenece a otro cliente)

---

#### POST `/api/apartados`
Crear un nuevo apartado.

**Headers:**
```
Authorization: Bearer <token>
```

**Body:**
```json
{
  "piezaId": 5,
  "cantidad": 2,
  "nota": "Urgente, recoger mañana"
}
```

**Response (201):**
```json
{
  "id": 1,
  "clienteId": 1,
  "piezaId": 5,
  "cantidad": 2,
  "estado": "PENDIENTE",
  "fechaCreacion": "2026-10-10T12:00:00.000Z",
  "fechaExpiracion": "2026-10-12T12:00:00.000Z",
  "nota": "Urgente, recoger mañana",
  "pieza": { ... }
}
```

**Validaciones:**
- `piezaId` y `cantidad` son obligatorios
- La pieza debe existir y estar activa
- La cantidad no puede exceder el stock disponible
- `nota` es opcional
- Estado inicial: PENDIENTE
- Expiración automática: 48 horas

**Errors:**
- 400: Pieza no disponible o cantidad excede stock
- 404: Pieza no encontrada

---

#### PUT `/api/apartados/:id/cancelar`
Cancelar un apartado (solo cliente).

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200):**
```json
{
  "id": 1,
  "clienteId": 1,
  "piezaId": 5,
  "cantidad": 2,
  "estado": "CANCELADO",
  "fechaCreacion": "2026-10-10T12:00:00.000Z",
  "fechaExpiracion": "2026-10-12T12:00:00.000Z",
  "nota": null,
  "pieza": { ... }
}
```

**Validaciones:**
- Solo el cliente dueño del apartado puede cancelarlo
- No se puede cancelar si el estado es LISTO_PARA_RECOGER o ENTREGADO

**Errors:**
- 400: No se puede cancelar en este estado
- 403: No autorizado
- 404: Apartado no encontrado

---

#### PUT `/api/apartados/:id/estado`
Actualizar estado de un apartado (solo personal administrativo).

**Headers:**
```
Authorization: Bearer <token-admin>
```

**Body:**
```json
{
  "estado": "CONFIRMADO"
}
```

**Estados válidos:**
- `PENDIENTE`
- `CONFIRMADO`
- `LISTO_PARA_RECOGER`
- `ENTREGADO`
- `CANCELADO`

**Response (200):**
```json
{
  "id": 1,
  "clienteId": 1,
  "piezaId": 5,
  "cantidad": 2,
  "estado": "CONFIRMADO",
  "fechaCreacion": "2026-10-10T12:00:00.000Z",
  "fechaExpiracion": "2026-10-12T12:00:00.000Z",
  "nota": null,
  "pieza": { ... }
}
```

**Requiere:** Rol ADMIN o EMPLEADO

---

### Configuración de Sucursal (`/api/sucursal`)

#### GET `/api/sucursal/config`
Obtener configuración de la sucursal (coordenadas, dirección, horario).

**Response (200):**
```json
{
  "nombre": "Refaccionaria Central",
  "direccion": "Av. Principal #123, Centro",
  "telefono": "+52 55 1234 5678",
  "horario": "Lun-Vie: 9:00-18:00, Sáb: 9:00-14:00",
  "coordenadas": {
    "latitud": 19.4326,
    "longitud": -99.1332
  }
}
```

**Nota:** Este endpoint es público (no requiere autenticación).

---

## Reglas de Negocio

### Expiración de Apartados
- Los apartados en estado PENDIENTE o CONFIRMADO expiran automáticamente a las 48 horas
- La verificación de expiración se realiza al consultar el apartado (campo `expirado` en la respuesta)
- El sistema no cancela automáticamente los apartados expirados; esto debe implementarse como un job programado si se requiere

### Reserva de Stock
- Crear un apartado NO reduce el inventario (reserva lógica)
- El stock se valida al crear el apartado (cantidad solicitada ≤ stock disponible)
- No se descuenta stock al pasar a ENTREGADO (esto debe manejarse desde la web si se requiere)

### Seguridad
- Tokens de clientes tienen `type: "client"` en el payload JWT
- Tokens de clientes NO pueden acceder a endpoints administrativos
- Tokens administrativos tienen `type` undefined y roles ADMIN/EMPLEADO
- El middleware `clientAuthRequired` valida que el token sea de tipo cliente
- El middleware `authRequired` valida tokens administrativos

---

## CORS

Se agregaron los siguientes orígenes permitidos para soportar la app móvil (Expo):
- `exp://192.168.*.*:8081`
- `exp://192.168.*.*:19000`
- `exp://localhost:8081`
- `exp://localhost:19000`

---

## Variables de Entorno

No se requieren nuevas variables de entorno. Se usan las existentes:
- `DATABASE_URL` - Cadena de conexión a PostgreSQL
- `JWT_SECRET` - Secreto para firmar tokens JWT
- `JWT_EXPIRES_IN` - Tiempo de expiración del token (default: 8h)
- `CORS_ORIGIN` - Orígenes permitidos para CORS
