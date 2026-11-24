import { Router } from "express";
import { createPart, deletePart, getPart, listParts, updatePart } from "../controllers/partController.js";
import { authRequired, loadActiveUser } from "../middleware/auth.js";

const router = Router();

router.get("/", listParts);
router.get("/:id", getPart);
router.post("/", authRequired, loadActiveUser, createPart);
router.put("/:id", authRequired, loadActiveUser, updatePart);
router.delete("/:id", authRequired, loadActiveUser, deletePart);

export default router;
