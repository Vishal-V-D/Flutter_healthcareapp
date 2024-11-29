import dash
from dash import dcc, html, Input, Output, State
import dash_bootstrap_components as dbc
import pandas as pd
import plotly.express as px
import base64
import io
import google.generativeai as genai

genai.configure(api_key="API_KEY")  # Replace with your actual API key
model = genai.GenerativeModel("gemini-1.5-flash")

app = dash.Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])


app.layout = dbc.Container([
    dbc.Row([dbc.Col(html.H1("CSV Analyzer with AI Assistant", className="text-center mb-4"))]),
    dbc.Row([
        dbc.Col(
            dcc.Upload(
                id='upload-data',
                children=html.Div(['Drag & Drop or ', html.A('Select CSV File')]),
                style={
                    'width': '100%', 'height': '60px', 'lineHeight': '60px',
                    'borderWidth': '1px', 'borderStyle': 'dashed',
                    'borderRadius': '5px', 'textAlign': 'center', 'margin': '10px'
                }
            ),
            width=12
        ),
    ]),
    dbc.Row([
        dbc.Col(dcc.Loading(id="loading-output", type="circle", children=html.Div(id='output-graph')), width=12)
    ]),
    dbc.Row([
        dbc.Col(dbc.Textarea(id="user-query", placeholder="Enter your query for analysis...", style={"width": "100%"}), width=10),
        dbc.Col(dbc.Button("Analyze", id="analyze-button", color="primary", className="mt-2"), width=2),
    ]),
    dbc.Row([dbc.Col(html.Div(id="analysis-result"), width=12)])
])


def parse_contents(contents):
    content_type, content_string = contents.split(',')
    decoded = base64.b64decode(content_string)
    try:
        return pd.read_csv(io.StringIO(decoded.decode('utf-8')))
    except Exception:
        return pd.DataFrame()


def analyze_data_with_gemini(df, user_query):
    try:
        data_str = df.to_string(index=False)
        response = model.generate_content(f"Analyze this data:\n{data_str}\nUser query: '{user_query}'")
        return response.text if response and response.text else "No response from Gemini AI."
    except Exception as e:
        return f"Error in Gemini API interaction: {str(e)}"

@app.callback(
    Output('output-graph', 'children'),
    Input('upload-data', 'contents'),
    prevent_initial_call=True
)
def update_graph(contents):
    if not contents:
        return html.Div("Please upload a valid CSV file.")
    
    df = parse_contents(contents)
    
    if df.empty:
        return html.Div("Uploaded CSV is empty or improperly formatted.")
    
    try:
        if len(df.columns) == 1:
            fig = px.bar(df, x=df.index, y=df.columns[0], title="Bar Chart")
        elif len(df.columns) == 2:
            fig = px.line(df, x=df.columns[0], y=df.columns[1], title="Line Graph", markers=True)
        elif len(df.columns) > 2:
            fig = px.scatter_matrix(df, dimensions=df.columns, title="Scatter Matrix Plot")
        else:
            fig = px.scatter(df, title="Scatter Plot")
        return dcc.Graph(figure=fig)
    except Exception as e:
        return html.Div(f"Error generating graph: {str(e)}")

@app.callback(
    Output("analysis-result", "children"),
    Input("analyze-button", "n_clicks"),
    State("user-query", "value"),
    State('upload-data', 'contents'),
    prevent_initial_call=True
)
def update_analysis(n_clicks, user_query, contents):
    if not contents:
        return "Please upload a CSV file for analysis."
    
    df = parse_contents(contents)
    
    if not user_query:
        return "Please enter a valid query."
    
    analysis_result = analyze_data_with_gemini(df, user_query)
    return html.Pre(analysis_result)

if __name__ == '__main__':
    app.run_server(debug=True)
