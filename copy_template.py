#!/usr/bin/env python3

# This script creates a new folder by copying the contents of a template folder.

# imports
import argparse
import os
import shutil

def create_new_folder(template_folder, folder, name):
    """
    Create a new folder by copying the contents of a template folder.

    Parameters:
    - template_folder (str): Path to the template folder.
    - folder (str): Path to the parent folder where the new folder will be created.
    - name (str): Name of the new folder.

    Returns:
    None
    """

    # create the new folder
    new_folder_path = os.path.join(folder, name)

    try:
        # copy file contents to the new folder
        shutil.copytree(template_folder, new_folder_path)
        print(f"New folder '{new_folder_path}' created successfully.")
    except FileNotFoundError:
        print(f"Template folder '{template_folder}' not found.")
    except FileExistsError:
        print(f"Destination folder '{new_folder_path}' already exists.")

if __name__ == "__main__":
    # Parse command-line arguments
    parser = argparse.ArgumentParser(description="Create a new folder from a template.")
    parser.add_argument(
        "template",
        help="Template folder path",
    )
    parser.add_argument(
        "folder",
        help="Parent folder path",
    )
    parser.add_argument(
        "name",
        help="New folder name",
    )
    args = parser.parse_args()

    # Create a new folder using the provided arguments
    create_new_folder(args.template, args.folder, args.name)
