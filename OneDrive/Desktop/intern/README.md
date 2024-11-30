# AI-Powered Graph Generator

This is a web application built using **Dash**, **Plotly**, and the **Gemini API**. The application allows users to upload CSV datasets, choose graph types, customize graph titles, and generate insights using AI. It's designed to be user-friendly, with an intuitive interface for visualizing and analyzing data.

## Features

- **File Upload**: Users can upload datasets in CSV format.
- **Graph Customization**: Choose from a variety of graph types (line, bar, scatter, pie, histogram).
- **AI Insights**: Ask AI questions about your data and get insights.
- **Dynamic Graphing**: Customize the graph title and select columns for the X and Y axes.
- **Real-Time Feedback**: Provides real-time analysis and feedback during graph generation and AI processing.

## How to Use

### 1. Clone the Repository

To clone the repository and set up the project locally, follow these steps:

- Open a terminal or command prompt.
- Navigate to the directory where you want to clone the project.
- Run the following command to clone the repository (replace `your-username` and `your-repo-name` with the appropriate values):

  ```bash
  git clone https://github.com/Vishal-V-D/Ai_graph_generator.git
This will create a local copy of the repository.

After cloning, navigate into the project directory:

bash
Copy code
cd Ai_graph_generator
2. Set Up a Virtual Environment
It's recommended to use a virtual environment to manage the dependencies for the project:

Create a virtual environment by running:

bash
Copy code
python -m venv venv
Activate the virtual environment:

On Windows, run:

bash
Copy code
venv\Scripts\activate
On Mac/Linux, run:

bash
Copy code
source venv/bin/activate
You should see (venv) in your terminal prompt, indicating that the virtual environment is active.

3. Install Dependencies
With the virtual environment activated, install the required libraries using the following command:

bash
Copy code
pip install -r requirements.txt
This will install the necessary dependencies listed in the requirements.txt file, including Dash, Plotly, pandas, etc.

4. Run the Application
Once the dependencies are installed, you can start the Dash app by running:

bash
Copy code
python app.py
The app will be accessible at http://127.0.0.1:8050/ in your web browser.

5. Upload Your Dataset
Click on the Upload Dataset section to upload your CSV file.
Once uploaded, select the graph type, customize the title, and choose the columns for the X and Y axes.
The AI will provide insights about your dataset.
6. Generate Insights
After uploading your data and customizing the graph, you can generate insights by asking questions about your dataset. The AI will respond with relevant answers based on the analysis of the data.

Dependencies
Dash: For creating the interactive web app.
Plotly: For generating dynamic graphs and charts.
Pandas: For data manipulation and analysis.
Gemini API: For generating AI-powered insights.
You can find the full list of dependencies in the requirements.txt file.

If you want to contribute to this project:

Fork the repository.
Create a new branch (git checkout -b feature-name).
Commit your changes (git commit -am 'Add new feature').
Push to the branch (git push origin feature-name).
Create a new pull request.