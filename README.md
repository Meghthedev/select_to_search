# **Select to Search**

## **"Circle to Search," but for Linux**

### **Overview**
This script brings the **Circle to Search** experience from Android to Linux, allowing you to **select any area on your screen and search for it using Google Lens**.

### **How It Works**
1. **Take a screenshot** of a selected area using **Flameshot**.
2. **Host the image locally** using a temporary web server.
3. **Expose it via Ngrok** to generate a publicly accessible link.
4. **Send the link to Google Lens** for searching.
5. **Auto-cleanup**: The script **self-destructs** after 60 seconds, removing the temporary image and stopping all background processes.

### **Installation**
#### **1. Install Dependencies**
Make sure you have the required dependencies installed:

```sh
sudo apt install flameshot curl jq xclip
```

#### **2. Install Ngrok**
If you don’t have Ngrok, install it from ngrok.com.
You will need to create a ngrok account, just follow  https://dashboard.ngrok.com/get-started/your-authtoken

#### **3. Clone the Repository**
```sh
git clone https://github.com/yourusername/select_to_search.git
cd select_to_search
chmod +x sts.sh
```
#### **Usage**
Assign the script (sts.sh) to a keyboard shortcut for quick access.

Select the area you want to search.
The image will open in Google Lens automatically.
Notes
The script automatically cleans up after 60 seconds.
If you encounter issues, ensure Ngrok is running properly.
You can customize the timeout or change the web server method if needed.
Contributing
If you have a better approach or ideas for improvement, feel free to open an issue or send a pull request!
