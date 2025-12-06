
# 🔫 Valorant Explorer - iOS App

**Valorant Explorer** es una aplicación nativa desarrollada en SwiftUI que permite a los jugadores consultar información detallada sobre Agentes, Mapas y el Arsenal del videojuego Valorant.

Este proyecto fue desarrollado como **Proyecto Final** para la Maestría en Tecnologías Web y Dispositivos Móviles, demostrando el dominio de desarrollo nativo en iOS, arquitectura limpia y consumo de servicios web.

---

## 📱 Descripción del Proyecto

La aplicación ofrece una experiencia inmersiva con una interfaz de usuario personalizada ("Tactical UI") inspirada en el diseño visual del juego. Permite a los usuarios autenticarse, explorar catálogos de datos en tiempo real y visualizar detalles técnicos de cada elemento del juego.

### 🚀 Características Principales (Features)

* **🔐 Autenticación Segura:** Sistema de Login y Registro persistente utilizando la API REST de **Firebase Auth**.
* **👥 Catálogo de Agentes:** Lista completa de personajes con filtrado en tiempo real y vista detallada de habilidades.
* **🗺️ Galería de Mapas:** Explorador de escenarios con visualización de planos tácticos (minimapas) y arte conceptual.
* **🔫 Arsenal Completo:** Lista de armas con estadísticas técnicas (cadencia, daño, precio) y visualización 3D simulada.
* **🎨 UI Táctica:** Diseño personalizado con modo oscuro forzado, tipografía militar y paleta de colores oficial (`#FF4655`).
* **🔍 Búsqueda Inteligente:** Buscador integrado en todas las listas (Agentes, Mapas y Armas).

---

## 🛠 Ficha Técnica

* **Framework UI:** SwiftUI
* **Arquitectura:** MVVM (Model-View-ViewModel)
* **Control de Versiones:** Git
* **Networking:** `URLSession` nativo con `async/await`

---

## ✅ Cumplimiento de Requisitos Técnicos (Rúbrica)

Este proyecto cumple con los 7 Requisitos Técnicos Obligatorios establecidos en las especificaciones del curso:

1.  **RT-1: Manejo de Estado Reactivo:**
    * Uso extensivo de `@State` para control local de UI.
    * Uso de `@Binding` en el componente reutilizable `SearchBar`.
    * Uso de `@Observable` (iOS 17) para la gestión de datos en los ViewModels.

2.  **RT-2: Navegación Robusta:**
    * Implementación de `TabView` para la navegación principal.
    * Uso de `NavigationStack` y `NavigationLink` para transiciones a vistas de detalle.

3.  **RT-3: Listas Dinámicas:**
    * Uso de `List`, `LazyVStack` y `ForEach` para renderizar colecciones de datos provenientes de APIs.

4.  **RT-4: Consumo de APIs REST:**
    * **API 1:** [Valorant-API.com](https://valorant-api.com/) (Datos de juego).
    * **API 2:** [Firebase Auth REST](https://firebase.google.com/docs/reference/rest/auth) (Autenticación de usuarios).
    * Implementación limpia con `Codable` y manejo de errores.

5.  **RT-5: Componentes Reutilizables:**
    * `SearchBar`: Barra de búsqueda funcional en 3 vistas.
    * `AgentRow` / `WeaponRow`: Celdas personalizadas con diseño complejo.
    * `CustomButton`: Botones estilizados consistentes.

6.  **RT-6: Carga de Imágenes Remotas:**
    * Implementación de `AsyncImage` con gestión de estados (carga, éxito, error) y placeholders.

7.  **RT-7: Manejo de Errores y Estados:**
    * Feedback visual al usuario mediante `ProgressView` (Loading) y mensajes de alerta en caso de fallos de red o autenticación.

---

## ⚙️ Instalación y Configuración

Para ejecutar este proyecto localmente, es necesario configurar las claves de API, ya que no se incluyen en el repositorio por seguridad.

1.  **Clonar el repositorio:**
    ```bash
    git clone [URL_DEL_REPOSITORIO]
    ```

2.  **Configurar API Keys:**
   
    *(Nota: La API de Valorant es pública y no requiere Key).*

3.  **Ejecutar:**
    Abre `FinalSwift.xcodeproj` en Xcode 15+ y ejecuta en un simulador (iPhone 17 Pro recomendado).

---

## 📂 Estructura del Proyecto (MVVM)

```text
FinalSwift/
├── App/                # Punto de entrada (@main)
├── Models/             # Estructuras de datos (Codable)
├── Views/              # Pantallas SwiftUI (Login, Home, Details)
├── ViewModels/         # Lógica de negocio y Estado (@Observable)
├── Services/           # Capa de red (URLSession)
├── Components/         # Vistas reutilizables (SearchBar, Rows)
└── Config/             # Archivos de configuración y constantes
