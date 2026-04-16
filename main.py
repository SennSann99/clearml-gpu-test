import torch
from clearml import Task

def main():
    # 1. ClearMLタスクの初期化
    task = Task.init(project_name="GPU_Test_Project", task_name="uv_gpu_check")
    
    # 2. 実行時に使うDockerイメージを指定（後でビルドするイメージ名）
    task.set_base_docker(
        docker_image="clearml_gpu_test_image",
        # ClearMLによる自動pip installをスキップ
        docker_setup_bash_script="echo 'Using uv pre-built environment'" 
    )

    # 3. GPUの認識チェック
    print("=== GPU Availability Check ===")
    is_available = torch.cuda.is_available()
    print(f"CUDA Available: {is_available}")
    
    if is_available:
        print(f"Device Name: {torch.cuda.get_device_name(0)}")
        print(f"Device Count: {torch.cuda.device_count()}")
    else:
        print("No GPU detected. Running on CPU.")
    print("==============================")

if __name__ == "__main__":
    main()