export async function getSucursalConfig(_req, res) {
  const config = {
    nombre: "Refaccionaria Central",
    direccion: "Av. Principal #123, Centro",
    telefono: "+52 55 1234 5678",
    horario: "Lun-Vie: 9:00-18:00, Sáb: 9:00-14:00",
    coordenadas: {
      latitud: 19.4326,
      longitud: -99.1332,
    },
  };

  return res.json(config);
}
