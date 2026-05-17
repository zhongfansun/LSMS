import json
import os
import pandas as pd

#生成lmm的答案的输入数据
output_split = 'train'

problems = json.load(open('data_files/okvqa_problems.json'))

system = []
query = []
response = []
images = []

for split, single_sample in problems.items():
    if single_sample['split'] == output_split:
        query_item = '<image>' + single_sample['question'] + ' Answer the question using a single word or phrase.'
        query.append(query_item)

        image_str = f'COCO_{output_split}2014_' + '0' * (12 - len(str(single_sample['image_id']))) + str(single_sample['image_id']) + '.jpg'
        images_item = os.path.join(f'data_files/{output_split}2014', image_str)
        images.append(images_item)

        GT_ans_item = single_sample['direct_answers']
        response_item = max(set(GT_ans_item), key=GT_ans_item.count)
        response.append(response_item)

llama_preds_df = pd.DataFrame(
    {'query': query, 'response': response, 'images': images}) #'system': system,
llama_preds_df.to_csv(f'okvqa_anstraining_{output_split}_dataset.csv', index=False)



