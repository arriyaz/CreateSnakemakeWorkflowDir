#!/bin/bash

# === SETTINGS ===
INSTALL_DIR="$HOME/.local/share/CreateSnakemakeWorkflowDir"
SCRIPT_NAME="CreateSnakemakeWorkflowDir.py"
CMD_NAME="CreateSnakemakeWorkflowDir"
CMD_PATH="/usr/local/bin/$CMD_NAME"
BASHRC="$HOME/.bashrc"
ALIAS_NAME="uninstall_CreateSnakemakeWorkflowDir"
ALIAS_COMMENT="# Uninstall alias for CreateSnakemakeWorkflowDir tool."
ALIAS_COMMAND="alias $ALIAS_NAME='sudo rm -f $CMD_PATH && sed -i \"/$ALIAS_COMMENT/d\" $BASHRC && sed -i \"/alias $ALIAS_NAME=/d\" $BASHRC && echo \"$CMD_NAME uninstalled and alias removed.\"'"

# === CREATE INSTALL DIR ===
mkdir -p "$INSTALL_DIR"

# === COPY PYTHON SCRIPT ===
cp "./$SCRIPT_NAME" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

# === CREATE SYMLINK ===
sudo ln -sf "$INSTALL_DIR/$SCRIPT_NAME" "$CMD_PATH"

# === ADD COMMENT + ALIAS TO .bashrc IF NOT PRESENT ===
if ! grep -q "$ALIAS_NAME" "$BASHRC"; then
    {
        echo ""
        echo "$ALIAS_COMMENT"
        echo "$ALIAS_COMMAND"
    } >> "$BASHRC"
    echo "Alias '$ALIAS_NAME' added to $BASHRC"
else
    echo "Alias '$ALIAS_NAME' already exists in $BASHRC"
fi

echo "✅ Installed successfully!"
echo "ℹ️ Run '$CMD_NAME' from anywhere."
echo "🧹 To uninstall later: run '$ALIAS_NAME' (after 'source ~/.bashrc')"
