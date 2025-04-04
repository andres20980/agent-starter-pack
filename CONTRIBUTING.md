# Cómo Contribuir

Nos encantaría aceptar tus parches y contribuciones a este ejemplo. Solo hay
unas pocas pautas que necesitas seguir.

## Acuerdo de Licencia para Contribuidores

Las contribuciones a este proyecto deben ir acompañadas de un Acuerdo de Licencia para Contribuidores. Tú (o tu empleador) conservas los derechos de autor de tu contribución; esto simplemente nos da permiso para usar y redistribuir tus contribuciones como parte del proyecto. Dirígete a [Google Developers CLA](https://cla.developers.google.com/) para ver tus acuerdos actuales en archivo o para firmar uno nuevo.

Generalmente solo necesitas enviar un CLA una vez, por lo que si ya has enviado uno (incluso si fue para un proyecto diferente), probablemente no necesites hacerlo de nuevo.

## Revisiones de Código

Todas las entregas, incluidas las realizadas por miembros del proyecto, requieren revisión. Usamos solicitudes de extracción (pull requests) de GitHub para este propósito. Consulta
[GitHub Help](https://help.github.com/articles/about-pull-requests/) para más
información sobre cómo usar solicitudes de extracción.

## Pautas de la Comunidad

Este proyecto sigue las [Pautas de la Comunidad de Código Abierto de Google](https://opensource.google/conduct/).

## Guía para Contribuidores

Si eres nuevo contribuyendo a código abierto, puedes encontrar información útil en esta guía para contribuidores.

Puedes seguir estos pasos para contribuir:

1. **Haz un fork del repositorio oficial.** Esto creará una copia del repositorio oficial en tu propia cuenta.
2. **Sincroniza las ramas.** Esto asegurará que tu copia del repositorio esté actualizada con los últimos cambios del repositorio oficial.
3. **Trabaja en la rama de características de tu repositorio bifurcado.** Aquí es donde realizarás tus cambios en el código.
4. **Confirma tus actualizaciones en la rama de características de tu repositorio bifurcado.** Esto guardará tus cambios en tu copia del repositorio.
5. **Envía una solicitud de extracción a la rama principal del repositorio oficial.** Esto solicitará que tus cambios se fusionen en el repositorio oficial.
6. **Resuelve cualquier error de linting.** Esto asegurará que tus cambios estén correctamente formateados.
   - Para errores generados por [check-spelling](https://github.com/check-spelling/check-spelling), ve al [Resumen del Trabajo](https://github.com/GoogleCloudPlatform/generative-ai/actions/workflows/spelling.yaml) para leer los errores.
     - Corrige cualquier error ortográfico que se encuentre.
     - Los Patrones Prohibidos están definidos como expresiones regulares, puedes copiarlos/pegarlos en muchos IDEs para encontrar las instancias. [Ejemplo para Visual Studio Code](https://medium.com/@nikhilbaxi3/visual-studio-code-secrets-of-regular-expression-search-71723c2ecbd2).
     - Añade falsos positivos a [`.github/actions/spelling/allow.txt`](.github/actions/spelling/allow.txt). ¡Asegúrate de que realmente esté correctamente escrito!

Aquí hay algunas cosas adicionales a tener en cuenta durante el proceso:

- **Lee las [Pautas de la Comunidad de Código Abierto de Google](https://opensource.google/conduct/).** Las pautas de contribución te proporcionarán más información sobre el proyecto y cómo contribuir.
- **Prueba tus cambios.** Antes de enviar una solicitud de extracción, asegúrate de que tus cambios funcionen como se espera.
- **Ten paciencia.** Puede tomar algún tiempo que tu solicitud de extracción sea revisada y fusionada.

---

## Para Empleados de Google

Si eres un empleado de Google, como requisito, sigue los pasos descritos en la [guía de contribución del repositorio de Generative AI de Google Cloud Platform](https://github.com/GoogleCloudPlatform/generative-ai/blob/main/CONTRIBUTING.md#for-google-employees) para procesos y requisitos.

## Comprobaciones de Calidad del Código

Para garantizar la calidad del código, utilizamos comprobaciones automatizadas. Antes de enviar una solicitud de extracción, ejecuta los siguientes comandos localmente:

```bash
make install
```

Esto instala las dependencias de desarrollo, incluidas las herramientas de linting.

Luego, ejecuta el siguiente comando Make:

```bash
make lint
```

Este comando ejecuta los siguientes linters para verificar el estilo del código, posibles errores y sugerencias de tipos:

- **codespell**: Detecta errores ortográficos comunes en el código y la documentación.
- **ruff**: Un linter y formateador rápido para Python, verifica errores, estándares de codificación y aplica consistencia en el estilo.
- **mypy**: Realiza comprobaciones estáticas de tipos para detectar errores de tipo antes de la ejecución.

```bash
make test
```

Este comando ejecuta la suite de pruebas usando pytest, cubriendo tanto pruebas unitarias como de integración:

Tu solicitud de extracción también será automáticamente revisada por estas herramientas usando GitHub Actions. Asegurarte de que tu código pase estas comprobaciones localmente ayudará a acelerar el proceso de revisión.
