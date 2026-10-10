import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { prisma } from "../config/prisma.js";
import { HttpError } from "../middleware/error.js";
import { isEmail, requireFields } from "../utils/validate.js";

function signClientToken(client) {
  return jwt.sign(
    { id: client.id, email: client.email, nombre: client.nombre, type: "client" },
    process.env.JWT_SECRET,
    { expiresIn: process.env.JWT_EXPIRES_IN || "8h" }
  );
}

function publicClient(client) {
  return {
    id: client.id,
    nombre: client.nombre,
    email: client.email,
    telefono: client.telefono,
    direccion: client.direccion,
    createdAt: client.createdAt,
  };
}

export async function registerClient(req, res, next) {
  try {
    requireFields(req.body, ["nombre", "email", "password"]);
    const { nombre, email, password, telefono, direccion } = req.body;

    if (!isEmail(email)) {
      throw new HttpError(400, "Email inválido.");
    }
    if (String(password).length < 8) {
      throw new HttpError(400, "La contraseña debe tener al menos 8 caracteres.");
    }

    const exists = await prisma.client.findUnique({ where: { email: String(email).trim().toLowerCase() } });
    if (exists) {
      throw new HttpError(409, "El email ya está registrado.");
    }

    const passwordHash = await bcrypt.hash(String(password), 10);
    const client = await prisma.client.create({
      data: {
        nombre: String(nombre).trim(),
        email: String(email).trim().toLowerCase(),
        passwordHash,
        telefono: telefono ? String(telefono).trim() : null,
        direccion: direccion ? String(direccion).trim() : null,
      },
    });

    const token = signClientToken(client);
    return res.status(201).json({ token, client: publicClient(client) });
  } catch (error) {
    return next(error);
  }
}

export async function loginClient(req, res, next) {
  try {
    requireFields(req.body, ["email", "password"]);
    const email = String(req.body.email).trim().toLowerCase();
    const client = await prisma.client.findUnique({ where: { email } });
    if (!client || !client.passwordHash) {
      throw new HttpError(401, "Credenciales inválidas.");
    }

    const ok = await bcrypt.compare(String(req.body.password), client.passwordHash);
    if (!ok) {
      throw new HttpError(401, "Credenciales inválidas.");
    }

    const token = signClientToken(client);
    return res.json({ token, client: publicClient(client) });
  } catch (error) {
    return next(error);
  }
}

export async function meClient(req, res, next) {
  try {
    const client = await prisma.client.findUnique({ where: { id: req.client.id } });
    if (!client) {
      throw new HttpError(401, "Cliente inexistente.");
    }
    return res.json({ client: publicClient(client) });
  } catch (error) {
    return next(error);
  }
}
