import { Router } from "express";
import { loginClient, meClient, registerClient } from "../controllers/clientAuthController.js";
import { clientAuthRequired } from "../middleware/clientAuth.js";

const router = Router();

router.post("/register", registerClient);
router.post("/login", loginClient);
router.get("/me", clientAuthRequired, meClient);

export default router;
