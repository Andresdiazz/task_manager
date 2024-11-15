# Task Manager App

Task Manager es una aplicación de lista de tareas creada en Flutter. Permite a los usuarios agregar, eliminar y marcar tareas como completadas, con un diseño modular y arquitectura limpia basada en los principios de arquitectura hexagonal. Este proyecto sigue los mejores patrones de diseño, optimización de gestión de estado y buenas prácticas de desarrollo.

## Características

- **Lista de Tareas**: Muestra una lista de tareas pendientes y completadas.
- **Agregar Tarea**: Permite agregar nuevas tareas.
- **Eliminar Tarea**: Posibilidad de eliminar tareas existentes.
- **Marcar Tarea como Completada**: Posibilidad de marcar tareas como completadas o pendientes.
- **Filtrar Tareas**: Opción de ver tareas por estado (pendientes/completadas).
- **Persistencia de Datos**: Las tareas se almacenan localmente y persisten incluso al cerrar y volver a abrir la aplicación.

## Requisitos Previos

- **Flutter**: La aplicación fue desarrollada en Flutter 3.16.3. Asegúrate de tener instalada esta versión o una versión más reciente.
- **Dart**: Asegúrate de que Dart esté correctamente configurado como parte de Flutter.
- **Herramientas de línea de comando**: git para clonar el repositorio y un editor de código como Visual Studio Code o Android Studio.

## Configuración del Proyecto

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/tu-usuario/task-manager-app.git
   cd task-manager-app

2. **Instalar dependencias Asegúrate de instalar todas las dependencias necesarias mediante:**
   ```bash
   flutter pub get

3. **Ejecutar el generador de código Este proyecto usa build_runner para generar código para los modelos. Ejecuta el siguiente comando:**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs

Ejecutar la aplicación Una vez configurado, puedes ejecutar la aplicación en un emulador o dispositivo físico con:
   
      
      flutter run

# Estructura del Proyecto

El proyecto sigue la arquitectura hexagonal para mantener un código modular y fácil de mantener. La estructura de carpetas es la siguiente:

- **lib/core:** Configuración de constantes y valores compartidos.
- **lib/domain:** Contiene las entidades y repositorios que definen la lógica de negocio.
- **lib/data:** Implementación de repositorios y fuentes de datos.
- **lib/application:** Lógica de negocio, con la implementación de BLoC para la gestión de estado.
- **lib/presentation:** Definición de widgets, pantallas y componentes de la interfaz de usuario.

## Descripción de Archivos Clave

- **task.dart:** Modelo de entidad Task en la capa de dominio.
- **task_repository.dart:** Definición de interfaz de repositorio de tareas en la capa de dominio.
- **task_repository_impl.dart:** Implementación del repositorio de tareas, encargada de la persistencia de datos.
- **task_bloc.dart:** BLoC que gestiona el estado de las tareas y la lógica de negocio.
- **task_screen.dart:** Pantalla principal donde se muestran las listas de tareas, con opciones para agregar, eliminar y marcar tareas.

# Ejecución de Pruebas
Para ejecutar las pruebas unitarias, usa el siguiente comando:

      flutter test
      
# Detalles de Implementación

- **Gestión de Estado:** Implementado usando BLoC, que asegura una separación clara entre la interfaz y la lógica de negocio.
- **Persistencia:** Las tareas se almacenan localmente para asegurar que persistan entre sesiones.
- **Filtros de Tareas:** Las tareas se dividen en listas de "pendientes" y "completadas" usando el BLoC para una gestión eficiente.
- **UI y Animaciones:** La interfaz es intuitiva, y se han añadido transiciones suaves para mejorar la experiencia del usuario.
