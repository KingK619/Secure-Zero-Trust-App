from flask import Flask, jsonify
import os
import psycopg2

try:
    from dotenv import load_dotenv
    load_dotenv()
except Exception:
    # python-dotenv not available in the runtime (OK in App Service where env vars are set)
    pass

app = Flask(__name__)

@app.route("/")
def home():
    return "Secure Azure Zero Trust Deployment Successful"

@app.route("/health")
def health():
    try:
        conn = psycopg2.connect(
            host=os.getenv("DB_HOST"),
            user=os.getenv("DB_USER"),
            password=os.getenv("DB_PASS"),
            dbname=os.getenv("DB_NAME"),
            sslmode="require"
        )
        conn.close()
        return jsonify({"status":"healthy"})
    except Exception as e:
        return jsonify({"error":str(e)}),500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)