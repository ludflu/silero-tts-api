from flask import Flask
from flask import request, abort, jsonify
from tempfile import NamedTemporaryFile

import simpleaudio as sa
import subprocess


import time

# V4
import torch

language = 'en'
model_id = 'v3_en'
sample_rate = 48000
speaker = 'en_0'
#device = torch.device('cpu')
device = torch.device('cuda')

model, example_text = torch.hub.load(repo_or_dir='snakers4/silero-models',
                                     model='silero_tts',
                                     language=language, speaker=model_id)
model.to(device)  # cuda or cpu
app = Flask(__name__)

@app.route('/talk', methods=['POST'])
def talk():
    start_time = time.time()
    data = request.json
    print(request)
    print(data)
    msg = data["message"]
    temp = NamedTemporaryFile()
    tempname = temp.name
    audio_paths = model.save_wav(audio_path=tempname, 
        text=msg,
        speaker=speaker,
        sample_rate=sample_rate)
    subprocess.run(["mpv", tempname])
    end_time = time.time()
    d = end_time - start_time
    resp = {"duration":d, "status":"ok"}
    return jsonify(resp)

if __name__ == "__main__":
    app.run(debug=True, port=5002)

