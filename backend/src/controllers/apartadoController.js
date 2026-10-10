import { prisma } from "../config/prisma.js";
import { HttpError } from "../middleware/error.js";
import { parseId, requireFields, toNumber } from "../utils/validate.js";

function apartadoData(body, isCreate) {
  if (isCreate) {
    requireFields(body, ["piezaId", "cantidad"]);
  }
  const data = {};
  if (body.piezaId !== undefined) data.piezaId = parseId(body.piezaId, "piezaId");
  if (body.cantidad !== undefined) data.cantidad = toNumber(body.cantidad, "cantidad", { integer: true, min: 1 });
  if (body.nota !== undefined) data.nota = body.nota ? String(body.nota).trim() : null;
  if (body.estado !== undefined) {
    const validEstados = ["PENDIENTE", "CONFIRMADO", "LISTO_PARA_RECOGER", "ENTREGADO", "CANCELADO"];
    if (!validEstados.includes(body.estado)) {
      throw new HttpError(400, "Estado inválido.");
    }
    data.estado = body.estado;
  }
  return data;
}

function calcularFechaExpiracion() {
  const fecha = new Date();
  fecha.setHours(fecha.getHours() + 48);
  return fecha;
}

function verificarExpiracion(apartado) {
  if (!apartado.fechaExpiracion) return false;
  return new Date() > apartado.fechaExpiracion;
}

export async function listApartados(req, res, next) {
  try {
    const { skip, take, page, pageSize, sortOrder } = require("../utils/validate.js").pagination(req.query);
    const sortBy = ["id", "fechaCreacion", "estado", "cantidad"].includes(req.query.sortBy)
      ? req.query.sortBy
      : "id";

    const where = { clienteId: req.currentClient.id };

    const [total, items] = await Promise.all([
      prisma.apartado.count({ where }),
      prisma.apartado.findMany({
        where,
        skip,
        take,
        orderBy: { [sortBy]: sortOrder },
        include: { pieza: true },
      }),
    ]);

    const itemsWithExpiracion = items.map((item) => ({
      ...item,
      expirado: verificarExpiracion(item),
    }));

    return res.json({ items: itemsWithExpiracion, total, page, pageSize });
  } catch (error) {
    return next(error);
  }
}

export async function getApartado(req, res, next) {
  try {
    const id = parseId(req.params.id);
    const apartado = await prisma.apartado.findUnique({
      where: { id },
      include: { pieza: true },
    });
    if (!apartado) {
      throw new HttpError(404, "Apartado no encontrado.");
    }
    if (apartado.clienteId !== req.currentClient.id) {
      throw new HttpError(403, "No autorizado.");
    }

    const expirado = verificarExpiracion(apartado);
    return res.json({ ...apartado, expirado });
  } catch (error) {
    return next(error);
  }
}

export async function createApartado(req, res, next) {
  try {
    const data = apartadoData(req.body, true);

    const pieza = await prisma.part.findUnique({ where: { id: data.piezaId } });
    if (!pieza) {
      throw new HttpError(404, "Pieza no encontrada.");
    }
    if (!pieza.activo) {
      throw new HttpError(400, "La pieza no está disponible.");
    }
    if (data.cantidad > pieza.stock) {
      throw new HttpError(400, "La cantidad solicitada excede el stock disponible.");
    }

    const apartado = await prisma.apartado.create({
      data: {
        ...data,
        clienteId: req.currentClient.id,
        estado: "PENDIENTE",
        fechaExpiracion: calcularFechaExpiracion(),
      },
      include: { pieza: true },
    });

    return res.status(201).json(apartado);
  } catch (error) {
    return next(error);
  }
}

export async function cancelarApartado(req, res, next) {
  try {
    const id = parseId(req.params.id);
    const apartado = await prisma.apartado.findUnique({
      where: { id },
      include: { pieza: true },
    });
    if (!apartado) {
      throw new HttpError(404, "Apartado no encontrado.");
    }
    if (apartado.clienteId !== req.currentClient.id) {
      throw new HttpError(403, "No autorizado.");
    }
    if (apartado.estado === "LISTO_PARA_RECOGER" || apartado.estado === "ENTREGADO") {
      throw new HttpError(400, "No se puede cancelar un apartado en este estado.");
    }

    const actualizado = await prisma.apartado.update({
      where: { id },
      data: { estado: "CANCELADO" },
      include: { pieza: true },
    });

    return res.json(actualizado);
  } catch (error) {
    return next(error);
  }
}

export async function updateApartadoEstado(req, res, next) {
  try {
    const id = parseId(req.params.id);
    const data = apartadoData(req.body, false);

    const apartado = await prisma.apartado.findUnique({ where: { id } });
    if (!apartado) {
      throw new HttpError(404, "Apartado no encontrado.");
    }

    const actualizado = await prisma.apartado.update({
      where: { id },
      data,
      include: { pieza: true },
    });

    return res.json(actualizado);
  } catch (error) {
    return next(error);
  }
}
