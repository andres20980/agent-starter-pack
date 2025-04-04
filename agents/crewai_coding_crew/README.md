# Agente CrewAI Coding Crew

Este agente combina las capacidades de IA colaborativa de CrewAI con LangGraph para proporcionar un asistente de codificación interactivo que puede entender requisitos y generar soluciones de código a través de la conversación.

## Arquitectura

El agente implementa una interfaz conversacional utilizando LangGraph que coordina con un equipo de desarrollo CrewAI. El flujo de trabajo consiste en:

1. Un agente conversacional que:
   - Recoge requisitos a través de un diálogo natural
   - Aclara ambigüedades haciendo preguntas de seguimiento
   - Delega el trabajo de codificación real al equipo de desarrollo CrewAI

2. Un equipo de desarrollo CrewAI compuesto por:
   - Ingeniero Senior: Responsable de implementar la solución de código
   - Ingeniero Jefe de QA: Evalúa y valida el código implementado

## Características Clave

- **Recopilación Interactiva de Requisitos**: Utiliza LangGraph para mantener un flujo de conversación natural mientras recopila y aclara los requisitos de codificación.
- **Desarrollo Colaborativo de IA**: Aprovecha el sistema multiagente de CrewAI para dividir el trabajo entre agentes de IA especializados.
- **Procesamiento Secuencial**: Las tareas se procesan en orden, desde la recopilación de requisitos hasta la implementación y la garantía de calidad.

## Cómo Funciona

1. El flujo de trabajo de LangGraph gestiona el estado de la conversación y determina cuándo:
   - Continuar la conversación para recopilar más requisitos
   - Delegar el trabajo al equipo de desarrollo CrewAI
   - Devolver los resultados al usuario

2. Cuando se necesita codificación, el equipo CrewAI se activa a través de una herramienta personalizada que:
   - Pasa los requisitos al agente Ingeniero Senior
   - Envía la implementación al Ingeniero de QA para su validación
   - Devuelve la solución final validada
