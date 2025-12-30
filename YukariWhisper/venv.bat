ECHO Start setup. It will take several minutes. Please wait
set temp=../tmp
set LOGFILE=..\setup_log.txt

ECHO ============================================ > %LOGFILE%
ECHO Setup Log - %DATE% %TIME% >> %LOGFILE%
ECHO ============================================ >> %LOGFILE%

ECHO. >> %LOGFILE%
ECHO [Python Version] >> %LOGFILE%
python --version >> %LOGFILE% 2>&1

ECHO. >> %LOGFILE%
ECHO [Pip Upgrade] >> %LOGFILE%
python -m pip install --upgrade pip >> %LOGFILE% 2>&1

REM For RTX 5000 series (SM120) support, install PyTorch from kentstone84's custom build
REM Requires Python 3.12. See: https://github.com/kentstone84/PyTorch-2.10.0a0
REM Official PyTorch (for non-RTX 5000): pip install torch==2.7.1 torchvision==0.22.1 torchaudio==2.7.1 --index-url https://download.pytorch.org/whl/cu128

ECHO. >> %LOGFILE%
ECHO [PyTorch Install (SM120 build)] >> %LOGFILE%
pip install "https://github.com/kentstone84/PyTorch-2.10.0a0/releases/download/v2.10.0a0-sm120/torch-2.10.0a0%%2Bsm120-cp312-cp312-win_amd64.whl" >> %LOGFILE% 2>&1
IF %ERRORLEVEL% NEQ 0 (
    ECHO ERROR: PyTorch install failed with error code %ERRORLEVEL% >> %LOGFILE%
    ECHO [WARNING] PyTorch install may have failed. Check setup_log.txt for details.
)

ECHO. >> %LOGFILE%
ECHO [Requirements Install] >> %LOGFILE%
pip install -r requirements.txt >> %LOGFILE% 2>&1

ECHO. >> %LOGFILE%
ECHO [Verification] >> %LOGFILE%
ECHO --- Torch Version --- >> %LOGFILE%
python -c "import torch; print(f'torch version: {torch.__version__}')" >> %LOGFILE% 2>&1
ECHO --- CUDA Available --- >> %LOGFILE%
python -c "import torch; print(f'CUDA available: {torch.cuda.is_available()}')" >> %LOGFILE% 2>&1
ECHO --- CUDA Architectures --- >> %LOGFILE%
python -c "import torch; print(f'CUDA arch list: {torch.cuda.get_arch_list() if hasattr(torch.cuda, \"get_arch_list\") else \"N/A\"}')" >> %LOGFILE% 2>&1
ECHO --- GPU Info --- >> %LOGFILE%
python -c "import torch; print(f'GPU: {torch.cuda.get_device_name(0) if torch.cuda.is_available() else \"N/A\"}')" >> %LOGFILE% 2>&1
python -c "import torch; print(f'GPU capability: {torch.cuda.get_device_capability(0) if torch.cuda.is_available() else \"N/A\"}')" >> %LOGFILE% 2>&1

ECHO. >> %LOGFILE%
ECHO [Installed Packages] >> %LOGFILE%
pip list >> %LOGFILE% 2>&1

ECHO ============================================ >> %LOGFILE%
ECHO Setup completed at %DATE% %TIME% >> %LOGFILE%
ECHO ============================================ >> %LOGFILE%

ECHO.
ECHO Setup is complete. Please run run.bat
ECHO Log file saved to: setup_log.txt
cd ../
PAUSE
deactivate
