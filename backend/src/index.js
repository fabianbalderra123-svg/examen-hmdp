import cors from "cors";
import dotenv from "dotenv";
import express from "express";
import { ensureAdmin } from "./config/ensureAdmin.js";
import { authRequired, loadActiveUser } from "./middleware/auth.js";
import { errorHandler, notFound } from "./middleware/error.js";
import apartadoRoutes from "./routes/apartadoRoutes.js";
import authRoutes from "./routes/authRoutes.js";
import clientAuthRoutes from "./routes/clientAuthRoutes.js";
import clientRoutes from "./routes/clientRoutes.js";
import dashboardRoutes from "./routes/dashboardRoutes.js";
import inventoryRoutes from "./routes/inventoryRoutes.js";
import movementRoutes from "./routes/movementRoutes.js";
import partRoutes from "./routes/partRoutes.js";
import sucursalRoutes from "./routes/sucursalRoutes.js";
import supplierRoutes from "./routes/supplierRoutes.js";
import userRoutes from "./routes/userRoutes.js";
import vehicleRoutes from "./routes/vehicleRoutes.js";

dotenv.config();

const app = express();
const origin = process.env.CORS_ORIGIN || "http://localhost:5173";
const allowedOrigins = [
  origin,
  "exp://192.168.*.*:8081",
  "exp://192.168.*.*:19000",
  "exp://localhost:8081",
  "exp://localhost:19000",
];

app.use(cors({ origin: allowedOrigins, credentials: true }));
app.use(express.json());

app.get("/api/health", (_req, res) => {
  res.json({ ok: true });
});

app.use("/api/auth", authRoutes);
app.use("/api/client-auth", clientAuthRoutes);
app.use("/api/users", authRequired, loadActiveUser, userRoutes);
app.use("/api/clients", authRequired, loadActiveUser, clientRoutes);
app.use("/api/vehicles", authRequired, loadActiveUser, vehicleRoutes);
app.use("/api/parts", partRoutes);
app.use("/api/suppliers", authRequired, loadActiveUser, supplierRoutes);
app.use("/api/inventory", authRequired, loadActiveUser, inventoryRoutes);
app.use("/api/movements", authRequired, loadActiveUser, movementRoutes);
app.use("/api/dashboard", authRequired, loadActiveUser, dashboardRoutes);
app.use("/api/apartados", apartadoRoutes);
app.use("/api/sucursal", sucursalRoutes);

app.use(notFound);
app.use(errorHandler);

const port = Number(process.env.PORT) || 4000;

ensureAdmin()
  .catch((error) => {
    console.error("No se pudo crear el usuario ADMIN:", error);
  })
  .finally(() => {
    app.listen(port, () => {
      console.log(`API escuchando en el puerto ${port}`);
    });
  });
