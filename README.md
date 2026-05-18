# Large-Small Model Synergy with Multimodal Fine-Grained Heuristics for Knowledge-Based Visual Question Answering

This repository provides the official implementation of:

**Large-Small Model Synergy with Multimodal Fine-Grained Heuristics for Knowledge-Based Visual Question Answering**

---

## Repository Structure

A typical structure of this repository is as follows:

```bash
LSMS/
├── data_files/
│   ├── train2014/
│   ├── val2014/
│   ├── mcan_okvqa_configs.json
│   ├── okvqa_problems.json
│   ├── mcan_ft_okvqa.pkl
│   ├── okvqa_train_data.pt
│   ├── okvqa_val_data.pt
│   └── ...
├── modeling_llava/
│   └── modeling_llava.py
├── scripts/
│   └── ...
├── okvqa_anstraining.py
├── run_all.sh
├── README.md
└── ...
```



---

## Environment Setup

We recommend using Conda to create a clean environment.

### 1. Create a New Environment

```bash
conda create -n LSMS python=3.10 -y
```

### 2. Activate the Environment

```bash
conda activate LSMS
```

### 3. Enter the Project Directory

```bash
cd LSMS
```

### 4. Install Dependencies

```bash
pip install -e '.[llm]'
pip install opencv-python
pip install opencv-python-headless==4.8.1.78
pip install torchscale==0.2.0
```

---

## Data Preparation

### 1. Download COCO 2014 Images

The OK-VQA dataset is built on COCO images. Please download the COCO 2014 training and validation images.

```bash
cd data_files/
wget http://images.cocodataset.org/zips/train2014.zip
wget http://images.cocodataset.org/zips/val2014.zip
unzip train2014.zip
unzip val2014.zip
```

After extraction, the directory should contain:

```bash
data_files/
├── train2014/
├── val2014/
├── train2014.zip
└── val2014.zip
```

You may remove the zip files after extraction if disk space is limited:

```bash
rm train2014.zip
rm val2014.zip
```

---

## MCAN Input Data and Model Weights

The MCAN input data can be extracted by running the Prophet codebase:

[https://github.com/MILVLG/prophet](https://github.com/MILVLG/prophet)

The MCAN model weights can be downloaded directly.

To make reproduction easier, we also provide the processed data and related files through Baidu Netdisk.



Baidu Netdisk link:

```text
https://pan.baidu.com/s/1jGq7EkDsZB6wn__aWhmQ8Q?pwd=wfcg
```

Extraction code:

```text
wfcg
```

Please note that the data files are being uploaded progressively.

---

## Generate Training Files

Before training, please run the following script to generate the required training files:

```bash
python okvqa_anstraining.py
```

---

## Training and Evaluation

We provide a unified script for training and evaluation.

```bash
bash run_all.sh
```

This script runs the main training and testing pipeline.

---

## Important Note: Replacing `modeling_llava.py`

Our implementation modifies the LLaVA modeling file in the `transformers` package. During execution, the following command is used:

```bash
cp $BASE_PATH/modeling_llava/modeling_llava.py /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py
```

This command replaces the corresponding `modeling_llava.py` file in the installed `transformers` package.

Before replacement, please back up the original file:

```bash
cp /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py \
   /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py.bak
```

Then replace it with our modified version:

```bash
cp $BASE_PATH/modeling_llava/modeling_llava.py \
   /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py
```

If you want to restore the original file, you can run:

```bash
cp /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py.bak \
   /usr/local/lib/python3.10/dist-packages/transformers/models/llava/modeling_llava.py
```

Please make sure that the path to your Python environment is correct. If your environment is not located at `/usr/local/lib/python3.10/`, you need to modify the path accordingly.

---

## Recommended Workflow

A typical workflow is as follows:

```bash
# 1. Create and activate environment
conda create -n LSMS python=3.10 -y
conda activate LSMS

# 2. Enter project directory
cd LSMS

# 3. Install dependencies
pip install -e '.[llm]'
pip install opencv-python
pip install opencv-python-headless==4.8.1.78
pip install torchscale==0.2.0

# 4. Prepare COCO images
cd data_files/
wget http://images.cocodataset.org/zips/train2014.zip
wget http://images.cocodataset.org/zips/val2014.zip
unzip train2014.zip
unzip val2014.zip
cd ..

# 5. Prepare MCAN features, model weights, and other required files

# 6. Generate training files
python okvqa_anstraining.py

# 7. Train and evaluate
bash run_all.sh
```

---

## Notes

1. Please ensure that all dataset paths and model paths are correctly set before running the training script.

2. If you use a custom Conda environment, the path to `modeling_llava.py` in the `transformers` package may be different from the default path used in our script.

3. The command for replacing `modeling_llava.py` should be used carefully. Please always back up the original file before replacement.

4. The processed data and intermediate files are being uploaded progressively. If some files are temporarily unavailable, please check the Baidu Netdisk link later.

5. The MCAN input data can also be generated manually using the Prophet repository.

---

## Acknowledgement

Our code is built upon an old version of Swift:

[https://github.com/modelscope/ms-swift](https://github.com/modelscope/ms-swift)

We sincerely thank the authors and contributors of Swift for their excellent open-source work.

We also thank the authors of Prophet for providing useful resources for MCAN-based VQA feature extraction:

[https://github.com/MILVLG/prophet](https://github.com/MILVLG/prophet)

---

## Citation

If you find this repository useful for your research, please consider citing our paper:

```bibtex
@inproceedings{sun2025large,
  title={Large-Small Model Synergy with Multimodal Fine-Grained Heuristics for Knowledge-Based Visual Question Answering},
  author={Sun, Zhongfan and Guo, Kan and Hu, Yongli and Tian, Daxin and Gao, Qingqing and Wang, Jiapu and Gao, Junbin and Sun, Yanfeng and Yin, Baocai},
  booktitle={Proceedings of the 33rd ACM International Conference on Multimedia},
  pages={935--944},
  year={2025}
}
```

---

## Contact

If you have any questions about the code or data preparation, please open an issue in this repository or contact the authors.
