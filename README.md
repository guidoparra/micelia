# Micelia

**Explorá la red que sostiene la vida.**

🌐 **Ver la web:** https://guidoparra.github.io/micelia/

Micelia es una web educativa, gratuita y de código abierto para explorar el reino Fungi sobre un globo interactivo.
Muestra mapas globales de hongos micorrícicos, áreas protegidas y la confiabilidad de los modelos,
con recorridos narrados en español.

## Cómo verla en tu computadora

El globo 3D combina texturas en el navegador, y eso no funciona si abrís `index.html` con doble clic.
Hace falta un servidor local:

- **Windows:** doble clic en `abrir_web.bat` (usa el Python que trae QGIS, o `py` si está instalado).
- **Cualquier sistema con Python:** `python -m http.server 8000` en esta carpeta y abrir
  <http://localhost:8000>.

## Estructura

```
index.html          Página completa (HTML, estilos y código)
autor.webp          Imagen de la sección «Acerca de»
abrir_web.bat       Servidor local para Windows
texturas/
  datos.js          Configuración de capas y grillas de valores (1024 x 512, uint8 + zlib)
  *.webp, *.png     Texturas equirectangulares de 4096 x 2048 para el globo y el mapa (WebP: con y sin pérdida según la capa)
```

## Datos y atribuciones

| Datos | Fuente | Licencia |
|---|---|---|
| Riqueza, rareza, densidad de hifas, incertidumbre y extrapolación | Society for the Protection of Underground Networks (SPUN) | [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) |
| Áreas protegidas | UNEP-WCMC e IUCN (2026), Protected Planet: The World Database on Protected Areas (WDPA), noviembre de 2026, Cambridge, Reino Unido. www.protectedplanet.net | [Términos de Protected Planet](https://www.protectedplanet.net/en/legal): uso no comercial, sin redistribución |
| Imágenes satelitales (mosaicos en vivo) | EOxCloudless 2020, EOX IT Services GmbH (contiene datos modificados de Copernicus Sentinel 2020) | CC BY-NC-SA 4.0 (uso no comercial) |
| Luces nocturnas (modo noche, mosaicos en vivo) | NASA Black Marble 2016 (VIIRS), servido por NASA EOSDIS GIBS | Dominio público |
| Imagen de respaldo del mapa 2D | Blue Marble de la NASA, incluida en el paquete three-globe | Dominio público (NASA) / MIT |
| Fotos de paisajes (cargadas en vivo) | Wikimedia Commons; autor y licencia de cada foto se muestran junto a ella | CC BY, CC BY-SA o dominio público |
| Fotos de hongos (cargadas en vivo) | iNaturalist, observaciones de grado de investigación | CC0, CC BY, CC BY-SA o CC BY-NC |
| Cielo estrellado (`texturas/cielo.webp`), logo e imagen para compartir | Generadas para este proyecto | CC BY 4.0 |
| Textura de la portada (`texturas/portada.webp`) | Visualización propia a partir de la densidad de hifas y la riqueza AM de SPUN | CC BY 4.0 |

Publicaciones de SPUN que hay que citar al usar sus datos:

- Van Nuland et al. (2025). *Global hotspots of mycorrhizal fungal richness are poorly protected.* Nature. https://doi.org/10.1038/s41586-025-09277-4
- Stewart et al. (2026). *Global density and biomass of arbuscular mycorrhizal fungal networks.* Science. https://doi.org/10.1126/science.adu4373

### Qué NO se sube a este repositorio

- **Los archivos originales de SPUN** (`MYCORRHIZAL_SPATIAL_MAPS.zip`, `capas/`): el link de descarga es
  personal. Quien los necesite debe pedirlos en spun.earth.
- **La base de la WDPA** (`WDPA_*.zip`, `*.gdb`, `capas/wdpa/`): sus términos prohíben redistribuirla.
  La web solo incluye una imagen rasterizada y una grilla de cobertura de baja resolución.

## Cómo se procesaron los datos

1. Mapas de SPUN reproyectados a EPSG:4326 y reducidos a 4096 x 2048 con `gdalwarp -r average`.
2. Paletas de color aplicadas entre los percentiles 2 y 98 de cada capa.
3. WDPA: polígonos con estado distinto de *Proposed*, sin reservas de biósfera de la UNESCO,
   rasterizados a 8192 x 4096 con `gdal_rasterize` y promediados a 4096 x 2048.
4. Grillas de la ficha: promedio en celdas de 0,35° (unos 39 km), cuantizado a 8 bits.
5. «Extrapolación» se muestra como 1 − valor de la capa *Extrapolation* de SPUN, que mide la cobertura
   de los datos de entrenamiento (Van Nuland et al., 2025). El estudio considera extrapolación por encima del 5 %.
6. Hotspots: el 5 % de la superficie terrestre con mayor riqueza AM (percentil 95 ponderado por área,
   como en el estudio). Con estos datos el umbral da 39,3 VT, frente a los 39,9 VT publicados.
7. Comparaciones del tipo «más que en el X % de la tierra»: percentiles ponderados por superficie,
   calculados sobre la misma grilla que muestra la ficha.

Los porcentajes de la capa «Hotspots AM y protección» y del recorrido «Hongos de Argentina» son
cálculos propios y aproximados; no reemplazan las cifras de los estudios.

## Advertencias

- Los mapas son predicciones de modelos, no mediciones directas. La riqueza se expresa en taxones
  estimados cada 100 m² (VT para hongos AM, OTU para EcM).
- Este sitio **no sirve para identificar hongos ni para decidir si un hongo es comestible**.
- Proyecto independiente, sin afiliación con SPUN, UNEP-WCMC ni IUCN.

## Licencia

- **Código:** MIT (ver `LICENSE`).
- **Textos y recorridos:** [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.es).
- **Datos:** mantienen sus propias licencias (ver tabla).

## Contacto

Guido Emanuel Parra · guido.emanuelparra@gmail.com
