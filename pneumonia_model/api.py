from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from tensorflow.keras.models import load_model
from tensorflow.keras.applications.xception import preprocess_input
from tensorflow.keras.preprocessing.image import img_to_array
import numpy as np
from PIL import Image
import io

app = FastAPI(title="Pneumonia Detection API")

# ---------------------------------------------
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# ---------------------------------------------

print("Loading Model...")
model = load_model('X-Ray_Pneumonia_classification.h5')
print("Model Loaded Successfully!")

@app.post("/predict")
async def predict_image(file: UploadFile = File(...)):
    try:
        image_data = await file.read()
        img = Image.open(io.BytesIO(image_data))
        
        if img.mode != 'RGB':
            img = img.convert('RGB')
            
        img = img.resize((299, 299))
        img_arr = img_to_array(img)
        img_arr = np.expand_dims(img_arr, axis=0)
        img_arr = preprocess_input(img_arr)
        
        pred = model.predict(img_arr)[0][0]
        
        if pred > 0.5:
            label = 'PNEUMONIA'
            confidence = float(pred * 100) # حولناها لـ float العادي عشان الـ JSON يفهمها
        else:
            label = 'NORMAL'
            confidence = float((1 - pred) * 100)
            
        return {
            "status": "success",
            "filename": file.filename,
            "prediction": label,
            "confidence": f"{confidence:.2f}%"
        }
        
    except Exception as e:
        return {"status": "error", "message": str(e)}

@app.get("/")
def read_root():
    return {"message": "Welcome to Pneumonia Detection API! Use the /predict endpoint."}