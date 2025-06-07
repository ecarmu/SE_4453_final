from flask import Flask, render_template, jsonify

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/hello')
def hello():
    return jsonify(message="Hello from Group 14!")

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)