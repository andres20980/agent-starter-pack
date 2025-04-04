# Instalación

Existen varias formas de instalar el Agent Starter Pack. Elige el método que mejor se adapte a tu flujo de trabajo.

## Usando pipx (Recomendado)

La forma recomendada de instalar el Agent Starter Pack es con [pipx](https://pypa.github.io/pipx/), que instala el paquete en un entorno aislado mientras hace que los comandos estén disponibles globalmente:

```bash
# Instala pipx si no lo tienes
python3 -m pip install --user pipx && python3 -m pipx ensurepath
source ~/.bashrc  # o ~/.zshrc dependiendo de tu shell

# Instala el Agent Starter Pack
pipx install agent-starter-pack
```

## Usando pip con un entorno virtual

También puedes instalar el Agent Starter Pack en un entorno virtual:

```bash
# Crea y activa un entorno virtual de Python
python -m venv venv && source venv/bin/activate

# Instala el Agent Starter Pack
pip install agent-starter-pack
```

## Usando uv (Instalador rápido de paquetes Python)

Para una experiencia de instalación más rápida, puedes usar [uv](https://astral.sh/uv):

```bash
# Instala uv si no lo tienes
curl -LsSf https://astral.sh/uv/install.sh | sh

source ~/.bashrc  # o ~/.zshrc dependiendo de tu shell

# Instala el Agent Starter Pack
uv pip install agent-starter-pack
```

## Primeros Pasos

Después de la instalación, puedes crear un nuevo proyecto de agente:

```bash
# Crea un nuevo proyecto de agente
agent-starter-pack create my-awesome-agent
```

## Actualización

Para actualizar, usa la misma herramienta que utilizaste para la instalación:

```bash
pipx upgrade agent-starter-pack  # Usando pipx
pip install --upgrade agent-starter-pack  # Usando pip
uv pip install --upgrade agent-starter-pack  # Usando uv
```

## Desinstalación

Para desinstalar, usa la misma herramienta que utilizaste para la instalación:

```bash
pipx uninstall agent-starter-pack # Usando pipx
pip uninstall agent-starter-pack  # Usando pip
uv pip uninstall agent-starter-pack  # Usando uv
```
