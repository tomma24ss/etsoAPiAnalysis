from nbclient import NotebookClient

# Path to your Jupyter Notebook file
notebook_path = "analyse.ipynb"

# Create a NotebookClient instance
client = NotebookClient(nb_path=notebook_path)

# Execute the notebook
client.execute()
