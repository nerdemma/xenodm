# Xenodm: Scripts y Temas Visuales

Este repositorio contiene una colección de archivos de configuración personalizados para el gestor de inicio de sesión **Xenodm**. El objetivo es proporcionar diversos temas y scripts que mejoran tanto la estética como la funcionalidad del login en sistemas X11 (como OpenBSD).

---

## 📝 Descripción

Los archivos incluidos permiten personalizar la experiencia de inicio de sesión desde el primer segundo. Estos scripts gestionan desde la apariencia visual hasta los procesos automáticos que se ejecutan antes de que el usuario ingrese sus credenciales.

### Archivos de Configuración Incluidos:

* **`Xsetup_0`**: Script encargado de la configuración de la pantalla (fondos de pantalla, resolución, lanzamiento de utilidades).
* **`Xresources`**: Define los estilos visuales, fuentes y colores de los widgets de Xenodm.
* **`install.sh`**: Script interactivo escrito en **ksh** para automatizar el respaldo de la configuración actual e instalar los nuevos temas.

---

## 🛠️ Instalación y Uso

El script de instalación es interactivo y te guiará durante el proceso de respaldo y despliegue.

1.  **Clonar el repositorio:**
    ```bash
    git clone [https://github.com/nerdemma/xenodm.git](https://github.com/nerdemma/xenodm.git)
    cd xenodm
    ```

2.  **Dar permisos de ejecución:**
    ```bash
    chmod +x install.sh
    ```

3.  **Ejecutar el instalador:**
    ```bash
    ./install.sh
    ```

---

## ⚙️ Características del Instalador (Ksh)

El script `install.sh` ha sido optimizado para ser robusto y seguro:

* **Recursividad:** Manejo inteligente de entradas de usuario para evitar errores de digitación.
* **Copias de Seguridad:** Antes de instalar, el script te permite crear un backup de tu directorio `/etc/X11/xenodm/` actual.
* **Seguridad:** Utiliza `doas` para garantizar que los archivos se copien con los permisos de sistema necesarios.

---

## ⚠️ Notas Importantes

* **Rutas:** El directorio por defecto de instalación es `/etc/X11/xenodm/`.
* **Dependencias:** Asegúrate de tener configurado `doas` en tu sistema para permitir la copia de archivos a directorios protegidos.
* **Personalización:** Se recomienda revisar el archivo `Xsetup_0` si utilizas herramientas específicas como `feh` o `xsetroot` para el fondo de pantalla.

---

## 🤝 Contribuciones

Si tienes un tema visual nuevo o una mejora para los scripts, ¡siéntete libre de abrir un **Pull Request** o reportar un **Issue**!

---

## 🤝 Novedades
* ** Sun Jan  4 21:29:28 -03 2026 :** Desarrollo de temas personalizados mediante script, validar colores, definir color de fondo y de texto. disponible en la carpeta /scripts/local


---



*Desarrollado con <3 por [nerdemma]*

