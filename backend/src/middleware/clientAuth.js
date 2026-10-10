import jwt from "jsonwebtoken";
import { prisma } from "../config/prisma.js";
import { HttpError } from "./error.js";

export function clientAuthRequired(req, _res, next) {
  const header = req.headers.authorization || "";
  const token = header.startsWith("Bearer ") ? header.slice(7) : null;
  if (!token) {
    return next(new HttpError(401, "No autenticado."));
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET);
    if (payload.type !== "client") {
      return next(new HttpError(403, "Token inválido para clientes."));
    }
    req.client = payload;
    return next();
  } catch {
    return next(new HttpError(401, "Token inválido o expirado."));
  }
}

export async function loadActiveClient(req, _res, next) {
  try {
    const client = await prisma.client.findUnique({ where: { id: req.client.id } });
    if (!client) {
      return next(new HttpError(401, "Cliente inexistente."));
    }
    req.currentClient = client;
    return next();
  } catch (error) {
    return next(error);
  }
}
