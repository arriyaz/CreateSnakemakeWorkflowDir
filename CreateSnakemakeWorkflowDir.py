#!/usr/bin/env python3

import os
from datetime import datetime

def main():
    # Prompt for user input
    project_name = input("What is the workflow name? ").strip()

    author_name = input("Who is your name (Default: Anisur Rahman)? ").strip()
    if not author_name:
        author_name = "Anisur Rahmna"

    print("What is the purpose of creating this workflow folder (press Enter twice to finish):")
    lines = []
    while True:
        line = input()
        if line == "":
            break
        lines.append(line)
    purpose = "\n".join(lines)

    # Create base project folder
    os.makedirs(project_name, exist_ok=True)

    # Define subfolder structure
    subfolders = [
        "config",
        "envs",
        "containers",
        "scripts",
        "output",
        "resources",
        "temp"
    ]

    # Create subfolders
    for sub in subfolders:
        os.makedirs(os.path.join(project_name, sub), exist_ok=True)

    # Write Snakefile inside the project folder
    snakefile_path = os.path.join(project_name, "Snakefile")
    with open(snakefile_path, "w") as sf:
        sf.write("# Snakefile for your workflow\n\nrule all:\n    input:\n        # Add your final targets here\n")

    # Write an empty config.yaml in the config folder
    config_path = os.path.join(project_name, "config", "config.yaml")
    with open(config_path, "w") as cf:
        cf.write("# Configuration file for the workflow\n")

    # Prepare README content
    now = datetime.now().strftime("%Y-%m-%d %I:%M:%S %p")
    readme_content = (
        f"# {project_name}\n\n"
        f"**Author:** {author_name}\n\n"
        f"**Date:** {now}\n\n"
        f"**Description:**\n{purpose}\n"
    )

    # Write README.md
    readme_path = os.path.join(project_name, "README.md")
    with open(readme_path, "w") as f:
        f.write(readme_content)

    print(f"✅ Workflow folder '{project_name}' created successfully.")
    print(f"📄 Snakefile created in: {snakefile_path}")
    print(f"⚙️  config.yaml created in: {config_path}")

if __name__ == "__main__":
    main()
