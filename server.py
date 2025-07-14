#!/usr/bin/env python3
"""
Simple HTTP server with CORS and Cross-Origin Isolation headers for Godot web exports
"""

import http.server
import socketserver
import os
import sys
from urllib.parse import urlparse

class GodotHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        # Add CORS headers
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', '*')
        
        # Add Cross-Origin Isolation headers required by Godot
        self.send_header('Cross-Origin-Embedder-Policy', 'require-corp')
        self.send_header('Cross-Origin-Opener-Policy', 'same-origin')
        
        # Cache control for better performance
        self.send_header('Cache-Control', 'no-cache')
        
        super().end_headers()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

    def guess_type(self, path):
        mimetype = super().guess_type(path)
        
        # Set proper MIME types for Godot files
        if path.endswith('.wasm'):
            return 'application/wasm'
        elif path.endswith('.pck'):
            return 'application/octet-stream'
        elif path.endswith('.js'):
            return 'application/javascript'
        
        return mimetype

def run_server(port=8000):
    # Change to the directory containing the web export files
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
    with socketserver.TCPServer(("", port), GodotHTTPRequestHandler) as httpd:
        print(f"🚀 Godot Web Server running at http://localhost:{port}/")
        print(f"📁 Serving files from: {os.getcwd()}")
        print(f"🌐 Open your game at: http://localhost:{port}/webexport.html")
        print("Press Ctrl+C to stop the server")
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n🛑 Server stopped")

if __name__ == "__main__":
    port = 8000
    if len(sys.argv) > 1:
        try:
            port = int(sys.argv[1])
        except ValueError:
            print("Invalid port number, using default 8000")
    
    run_server(port)
