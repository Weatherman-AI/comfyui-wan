# ComfyUI WAN 2.2 - S2V

**ComfyUI** with **WAN 2.2 (s2v)** on NVIDIA GPUs via RunPod.  
Includes optional model installs (s2v & i2v), upscalers, interpolation, LoRA support, and helper utilities.

**Version:** v0.0.2

---

## Features

- **Base:** `nvidia/cuda:12.8`
- **WAN 2.2 Support:**
  - i2v 14b (image → video)
  - s2v 14b (sound → video)
  - Enabled via environment variables
- **Models / Checkpoints:**
  - `umt5_xxl_fp8_e4m3fn_scaled.safetensors` for CLIP
  - `wan2.2_vae` (default) or `wan2.1_vae` (optional)
  - `4xlsdir.pth` upscaler
- **ComfyUI Built-ins:**
  - LoRA support (disabled by default)
  - Downloader for [CivitAI](https://civitai.com/) models  
    - Requires **CivitAI token** + version # via environment variables
- **Interpolation:** RIFE frame interpolation  
  - Default: 16 → 30fps (for social media)  
  - Configurable to arbitrary FPS
- **Sampler Options:** ClownSharkSampler for high/low noise (i2v workflows)
- **RunPod Optimized:** Pre-configured for pod templates and GPU persistence

---

## Getting Started

### Prerequisites
- [RunPod](https://runpod.io/) account with GPU access

### GPU Selection
- When Deploying a Pod, expand `Additional Filters` and select CUDA Version `12.8`
- Minimum recommended GPU spec is 48 GB VRAM (e.g. L40S)

### Environment Variables
Control optional installs and features using env vars:

| Variable | Accepted Values | Description |
|----------|-----------------|-------------|
| `INSTALL_WAN22_I2V` | `true` / `false` | Install WAN 2.2 i2v 14b |
| `INSTALL_WAN22_S2V` | `true` / `false` | Install WAN 2.2 s2v 14b |
| `CIVITAI_TOKEN` | `<token>` | API token for CivitAI downloads |
| `LORAS_IDS_TO_DOWNLOAD` | `<version_id>` | Specific version # to fetch |

---

## Usage

### RunPod
1. Launch a pod with **CUDA 12.8** base.  
2. Set environment variables (see above).  
3. Ensure ComfyUI & JupyterLab service ports exposed (default `8188` & `8888`).  
