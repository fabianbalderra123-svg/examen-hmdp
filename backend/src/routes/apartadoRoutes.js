import { Router } from "express";
import { cancelarApartado, createApartado, getApartado, listApartados, updateApartadoEstado } from "../controllers/apartadoController.js";
import { clientAuthRequired, loadActiveClient } from "../middleware/clientAuth.js";
import { authRequired, loadActiveUser, requireRoles } from "../middleware/auth.js";

const router = Router();

router.get("/", clientAuthRequired, loadActiveClient, listApartados);
router.get("/:id", clientAuthRequired, loadActiveClient, getApartado);
router.post("/", clientAuthRequired, loadActiveClient, createApartado);
router.put("/:id/cancelar", clientAuthRequired, loadActiveClient, cancelarApartado);

router.put("/:id/estado", authRequired, loadActiveUser, requireRoles("ADMIN", "EMPLEADO"), updateApartadoEstado);

export default router;
