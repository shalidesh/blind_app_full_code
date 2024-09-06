from flask import Flask, request
import base64
from PIL import Image
from io import BytesIO
import numpy as np

# Load main packages
import numpy as np # linear algebra
import os
import json

# Load CNN packages
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from keras.layers import Dense
from keras.models import Sequential, load_model

from keras.models import load_model

# Load the pre-trained model from the .h5 file
model = load_model('models//color_detection.h5')
IMG_SIZE = (224, 224)
classes=['black',
        'blue',
        'brown',
        'green',
        'grey',
        'orange',
        'pink',
        'purple',
        'red',
        'silver',
        'white',
        'yellow']

app = Flask(__name__)

@app.route('/save', methods=['POST'])
def receive_image():
    image_data = request.form['image']
    image_data = base64.b64decode(image_data)
    image = Image.open(BytesIO(image_data))
    image.save('image.jpg', 'JPEG')

    raw_img = keras.preprocessing.image.load_img('image.jpg', target_size=IMG_SIZE)

    # Conver to numpy array
    img_array = keras.preprocessing.image.img_to_array(raw_img)

    # Reshaping
    img_array = tf.expand_dims(img_array, 0)  # Create batch axis

    # Make predictions
    predictions = model.predict(img_array)
    # print(predictions)
    # Get score
    proba      = np.max(predictions)
    print(proba)
    # print(np.argmax(predictions))
    pred_class = classes[np.argmax(predictions)]
    print(pred_class)

    reccomendation=""

    # Open the file for reading
    with open('recomendation_text.json', 'r') as file:
        # Load the JSON data from the file
        data = json.load(file)

    # Get the value for the key 'Black'
    reccomendation = data.get(pred_class)
    print(reccomendation)
    text=f"This dress is {pred_class} at {round(proba * 100,2)}%.{reccomendation}"

    return {"sucess":f"This dress is {pred_class} at {round(proba * 100,2)}%","reccomend":text}


if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8443))
    app.run(host='0.0.0.0', port=port,debug=True)   


