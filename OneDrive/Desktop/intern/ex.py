import dash
from dash import dcc, html, Input, Output, State
import dash_bootstrap_components as dbc
import pandas as pd
import plotly.express as px
import base64
import io
from flask_cors import CORS
import google.generativeai as genai

# Initialize Gemini API
genai.configure(api_key="AIzaSyDEEpr5mEHlHLN7_JeDzF-Rk5bBaF5RBFk")  # Replace with your API key
model = genai.GenerativeModel("gemini-1.5-flash")

app = dash.Dash(__name__, external_stylesheets=[dbc.themes.BOOTSTRAP])
CORS(app.server)

app.layout = dbc.Container([
    dbc.Row([dbc.Col(html.H1("Dynamic CSV Analyzer with AI Assistance", className="text-center mb-4"))]),

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
            ), width=12
        ),
    ]),

    dbc.Row([dbc.Col(html.Div(id='file-status', children="No file uploaded yet."), width=12)]),

    dbc.Row([
        dbc.Col([
            dbc.Label("Select Graph Type"),
            dcc.Dropdown(
                id='graph-type-dropdown',
                options=[
                    {'label': 'Bar Chart', 'value': 'bar'},
                    {'label': 'Line Chart', 'value': 'line'},
                    {'label': 'Scatter Plot', 'value': 'scatter'},
                    {'label': 'Pie Chart', 'value': 'pie'}
                ],
                value='scatter',
                placeholder="Select a graph type"
            ),
        ], width=6),
    ]),

    dbc.Row([
        dbc.Col([
            dbc.Label("Select Row Range"),
            dcc.RangeSlider(
                id='row-range-slider',
                min=1, max=500, step=1, value=[1, 10],
                tooltip={"placement": "bottom", "always_visible": True},
                marks={i: str(i) for i in range(0, 501, 100)}
            )
        ], width=6),
    ]),

    dbc.Row([dbc.Col(dcc.Loading(id="loading-output", type="circle", children=html.Div(id='output-graph')), width=12)]),

    dbc.Row([
        dbc.Col(
            dbc.Textarea(id="user-query", placeholder="Ask a question about your data...", style={"width": "100%"}),
            width=10
        ),
        dbc.Col(
            dbc.Button("Ask AI", id="analyze-button", color="primary", className="mt-2"),
            width=2
        ),
    ]),

    dbc.Row([dbc.Col(html.Div(id="analysis-result"), width=12)]),

    dbc.Row([
        dbc.Col(
            dbc.Button("Download Graph Data", id="download-button", color="info", className="mt-2"),
            width=2
        ),
        dcc.Download(id="download-dataframe-csv"),
    ]),

    html.Div(id="graph-data", style={"display": "none"})
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
        return response.text.replace("**", "").strip() if response and response.text else "No response from Gemini AI."
    except Exception as e:
        return f"Error in Gemini API interaction: {str(e)}"

@app.callback(
    [Output('file-status', 'children'),
     Output('output-graph', 'children'),
     Output('graph-data', 'children')],
    [Input('upload-data', 'contents'),
     Input('row-range-slider', 'value'),
     Input('graph-type-dropdown', 'value')],
    prevent_initial_call=True
)
def update_graph(contents, row_range, graph_type):
    if not contents:
        return "No file uploaded yet.", "", ""

    df = parse_contents(contents)
    if df.empty:
        return "Uploaded CSV is empty or improperly formatted.", "", ""

    file_status = f"File uploaded with {df.shape[0]} rows and {df.shape[1]} columns."
    start_row, end_row = row_range
    df_filtered = df.iloc[start_row - 1:end_row]

    if len(df_filtered.columns) < 2:
        return file_status, "Please upload a CSV with at least two columns.", ""

    x_col, y_col = df_filtered.columns[0], df_filtered.columns[1]

    try:
        if graph_type == 'bar':
            fig = px.bar(df_filtered, x=x_col, y=y_col)
        elif graph_type == 'line':
            fig = px.line(df_filtered, x=x_col, y=y_col)
        elif graph_type == 'scatter':
            fig = px.scatter(df_filtered, x=x_col, y=y_col)
        elif graph_type == 'pie' and df_filtered[y_col].dtype in ['int64', 'float64']:
            fig = px.pie(df_filtered, names=x_col, values=y_col)
        else:
            fig = px.scatter(df_filtered, x=x_col, y=y_col)

        fig.update_layout(
            plot_bgcolor='rgba(255,255,255,1)',
            xaxis=dict(showgrid=True, gridcolor='lightgrey'),
            yaxis=dict(showgrid=True, gridcolor='lightgrey')
        )

        return file_status, dcc.Graph(figure=fig), df_filtered.to_json()

    except Exception as e:
        return file_status, f"Error generating graph: {str(e)}", ""

@app.callback(
    Output("analysis-result", "children"),
    Input("analyze-button", "n_clicks"),
    State("user-query", "value"),
    State("graph-data", "children"),
    prevent_initial_call=True
)
def analyze_query(n_clicks, user_query, data):
    if not data:
        return "Please upload a CSV file first."
    
    df = pd.read_json(data)
    if user_query:
        analysis = analyze_data_with_gemini(df, user_query)
        return html.Ul([html.Li(point) for point in analysis.split(". ")])
    return "Please provide a query for analysis."

@app.callback(
    Output("download-dataframe-csv", "data"),
    Input("download-button", "n_clicks"),
    State("graph-data", "children"),
    prevent_initial_call=True
)
def download_filtered_csv(n_clicks, data):
    if n_clicks and data:
        df = pd.read_json(data)
        return dcc.send_data_frame(df.to_csv, "graph_data.csv")

if __name__ == '__main__':
    app.run_server(debug=True)
