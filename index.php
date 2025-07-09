<?php
$data = json_decode(file_get_contents("/opt/more/datos.json"), true);
?>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Monitoreo del sistema</title>
  <meta http-equiv="refresh" content="10">
  <style>
    body { background: #111; color: #0f0; font-family: monospace; padding: 2em; }
    table td { padding: 6px 12px; }
    h2 { color: #6ef; }
    .critico { color: #f55; font-weight: bold; }
    .alto { color: #ff5; }
    .moderado { color: #5f5; }
  </style>
</head>
<body>
  <h2>INFORMACIÓN - <?= $data['fecha'] ?></h2>
  <p style="color:#ccc;">
    <strong>HOST:</strong> <?= $data['hostname'] ?><br>
    <strong>SISTEMA OPERATIVO:</strong> <?= $data['os'] ?><br>
    <strong>KERNEL:</strong> <?= $data['kernel'] ?> | <?= $data['arquitectura'] ?>
  </p>
  <table>
    <tr><td>CPU</td><td><?= $data['cpu'] ?>%</td></tr>
    <tr><td>RAM</td><td><?= $data['ram_usada'] ?>/<?= $data['ram_total'] ?> MB (<?= $data['ram_porcentaje'] ?>%)</td></tr>
    <tr><td>DISCO</td><td><?= $data['disco'] ?></td></tr>
    <tr><td>TIEMPO DE ACTIVIDAD</td><td><?= $data['uptime'] ?></td></tr>
    <tr><td>USUARIOS ACTIVOS</td><td><?= $data['usuarios'] ?></td></tr>
    <tr><td>CARGA PROMEDIO</td>
      <td><?= $data['carga_1m'] ?>, <?= $data['carga_5m'] ?>, <?= $data['carga_15m'] ?> (1m/5m/15m)</td>
    </tr>
    <tr><td>ESTADO</td>
      <td class="<?= strtolower($data['estado']) ?>"><?= $data['estado'] ?></td>
    </tr>
  </table>

  <h3>TOP 5 PROCESOS POR USO DE CPU</h3>
  <table border="1" cellpadding="6">
    <tr><th>PID</th><th>Comando</th><th>%CPU</th><th>%MEM</th></tr>
    <?php foreach ($data['procesos'] as $p): ?>
      <tr>
        <td><?= $p['pid'] ?></td>
        <td><?= $p['cmd'] ?></td>
        <td><?= $p['cpu'] ?></td>
        <td><?= $p['mem'] ?></td>
      </tr>
    <?php endforeach; ?>
  </table>
</body>
</html>
