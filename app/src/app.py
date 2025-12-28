from flask import Flask, jsonify
import os
import socket
from datetime import datetime

app = Flask(__name__)

APP_NAME = os.getenv("APP_NAME", "cloud-native-demo")
APP_ENV = os.getenv("APP_ENV", "dev")
APP_VERSION = os.getenv("APP_VERSION", "1.0.0")

@app.route("/")
def index():
    return jsonify({
        "app": APP_NAME,
        "environment": APP_ENV,
        "version": APP_VERSION,
        "hostname": socket.gethostname(),
        "timestamp": datetime.utcnow().isoformat() + "Z"
    })

@app.route("/health")
def health():
    return jsonify({"status": "ok"})

@app.route("/qa")
def qa():
    return jsonify({
        "qa_environment": True,
        "tests_enabled": True,
        "message": "Dynamic QA environment ready"
    })

@app.route("/load")
def load():
    total = 0
    for _ in range(10_000_000):
        total += 1
    return {"status": "ok", "load": total}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)