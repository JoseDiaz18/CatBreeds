# 🐱 Cat Breeds App

Una aplicación Flutter que muestra razas de gatos utilizando [The Cat API](https://thecatapi.com/). Implementa Clean Architecture, patrón Bloc + Cubit, inyección de dependencias con `get_it`, y gestión de variables sensibles con `.env`.

## 📸 Captura de pantalla



## ✨ Características

- Consulta de razas de gatos desde una API externa
- Búsqueda interactiva por nombre de raza (en inglés)
- Arquitectura limpia por capas: `data`, `domain`, `presentation`
- Manejo de estado con Bloc y Cubit
- Inyección de dependencias usando GetIt
- Protección de la API Key mediante archivo `.env`

## 🚀 Tecnologías

- Flutter
- Bloc & Cubit
- Dio
- GetIt
- flutter_dotenv
- Clean Architecture

## 🗂 Estructura del proyecto

```bash
/lib
  ├── core/                      # Configuración general (Dio, estilos, utilidades)
  ├── features/
  │   └── cats/
  │       ├── data/              # Data sources, models y repositoryImpl
  │       ├── domain/            # Repositories y UseCases
  │       └── presentation/      # Cubits, UI y widgets
  ├── injection_container.dart   # Dependency Injection
  └── main.dart

/assets
  └── .env                       # Recusos 

apiKey=tu_api_key
baseUrl=https://api.thecatapi.com/v1

