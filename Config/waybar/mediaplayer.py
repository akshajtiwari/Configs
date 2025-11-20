#!/usr/bin/env python3
import subprocess
import json

try:
    status = subprocess.run(['playerctl', 'status'], capture_output=True, text=True).stdout.strip()
    artist = subprocess.run(['playerctl', 'metadata', 'artist'], capture_output=True, text=True).stdout.strip()
    title = subprocess.run(['playerctl', 'metadata', 'title'], capture_output=True, text=True).stdout.strip()
    
    if status == "Playing":
        output = {"text": f"{artist} - {title}", "class": "playing", "alt": "playing"}
    elif status == "Paused":
        output = {"text": f"{artist} - {title}", "class": "paused", "alt": "paused"}
    else:
        output = {"text": "", "class": "stopped", "alt": "stopped"}
    
    print(json.dumps(output))
except:
    print(json.dumps({"text": "", "class": "stopped"}))
