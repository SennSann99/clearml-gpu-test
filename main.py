import torch
import argparse
from clearml import Task

def main():
    # 引数の受け取り（CLIから上書き可能）
    parser = argparse.ArgumentParser()
    parser.add_argument('--dataset-id', type=str, default='default_id')
    args = parser.parse_args()

    # 1. タスクの初期化
    task = Task.init(project_name="My_GPU_Project", task_name="uv_remote_run")
    
    # 2. 実際の処理（GPU確認テスト）
    print(f"Dataset ID: {args.dataset_id}")
    print(f"CUDA Available: {torch.cuda.is_available()}")
    if torch.cuda.is_available():
        print(f"GPU Name: {torch.cuda.get_device_name(0)}")

if __name__ == "__main__":
    main()
