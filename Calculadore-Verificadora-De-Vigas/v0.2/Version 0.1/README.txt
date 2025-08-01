# Calculadora de Vigas AISC

Aplicación web para verificar vigas de acero simplemente apoyadas según la normativa AISC utilizando el método LRFD.

## 🧮 ¿Qué hace?

- Recibe:
  - Longitud de la viga (`L`)
  - Carga distribuida (`P`)
  - Módulo resistente de la sección (`Sx`)
  - Resistencia a la fluencia del acero (`Fy`)
- Calcula:
  - Momento flector máximo
  - Momento resistente de diseño
  - Verifica si la sección cumple

## 🛠️ Tecnologías

- Backend: Node.js + Express
- Frontend: React
- API: `POST /api/verificar`

## 🚀 Cómo levantarlo localmente

### 1. Clonar repositorio

```bash
git clone https://github.com/TU_USUARIO/calculadora-vigas-aisc.git
cd calculadora-vigas-aisc
