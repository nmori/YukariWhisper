ECHO Start setup. It will take several minutes. Please wait
set temp=../tmp
python -m pip install --upgrade pip
REM For RTX 5000 series (SM120) support, install PyTorch from kentstone84's custom build
REM Requires Python 3.12. See: https://github.com/kentstone84/PyTorch-2.10.0a0
REM Official PyTorch (for non-RTX 5000): pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1 --index-url https://download.pytorch.org/whl/cu128
pip install https://github.com/kentstone84/PyTorch-2.10.0a0/releases/download/v2.10.0a0-sm120/torch-2.10.0a0+sm120-cp312-cp312-win_amd64.whl
pip install -r requirements.txt

ECHO Setup is complete. Please run run.bat
cd ../
PAUSE
deactivate
