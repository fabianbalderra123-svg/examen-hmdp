import { Router } from "express";
import { getSucursalConfig } from "../controllers/sucursalController.js";

const router = Router();

router.get("/config", getSucursalConfig);

export default router;
