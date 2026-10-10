-- CreateEnum
CREATE TYPE "ApartadoEstado" AS ENUM ('PENDIENTE', 'CONFIRMADO', 'LISTO_PARA_RECOGER', 'ENTREGADO', 'CANCELADO');

-- AlterTable
ALTER TABLE "clients" ADD COLUMN "password_hash" TEXT;

-- CreateIndex
CREATE UNIQUE INDEX "clients_email_key" ON "clients"("email");

-- CreateTable
CREATE TABLE "apartados" (
    "id" SERIAL NOT NULL,
    "cliente_id" INTEGER NOT NULL,
    "pieza_id" INTEGER NOT NULL,
    "cantidad" INTEGER NOT NULL,
    "estado" "ApartadoEstado" NOT NULL DEFAULT 'PENDIENTE',
    "fecha_creacion" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "fecha_expiracion" TIMESTAMP(3),
    "nota" TEXT,

    CONSTRAINT "apartados_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "apartados" ADD CONSTRAINT "apartados_cliente_id_fkey" FOREIGN KEY ("cliente_id") REFERENCES "clients"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "apartados" ADD CONSTRAINT "apartados_pieza_id_fkey" FOREIGN KEY ("pieza_id") REFERENCES "parts"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
