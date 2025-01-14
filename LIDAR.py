import numpy as np
import pandas as pd
from sklearn.cluster import DBSCAN
import laspy

# 导入点云数据
def load_las(file_path):
    las = laspy.read(file_path)
    points = np.vstack([las.x, las.y, las.z]).T
    return points

# 导出聚类结果
def save_las(output_path, las_file, labels):
    las_file.classification = labels
    las_file.write(output_path)

# 加载点云数据
input_file = "D:\Califulia_Lidar\downsampled_data\downsampled_cleaned_ground_Quzao_0000000.las"
points = load_las(input_file)

# DBSCAN聚类
db = DBSCAN(eps=0.5, min_samples=10, metric='euclidean')
labels = db.fit_predict(points)

import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 可视化聚类结果
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.scatter(points[:, 0], points[:, 1], points[:, 2], c=labels, cmap='viridis', marker='o')
plt.show()

# 保存聚类结果
las_file = laspy.read(input_file)
output_file = "D:/Califulia_Lidar/clustered_data/clustered_0000000.las"
save_las(output_file, las_file, labels)

# 去除噪声点
filtered_points = points[labels != -1]
filtered_labels = labels[labels != -1]

# 分割出每棵树
unique_labels = np.unique(filtered_labels)
for label in unique_labels:
    if label != -1:
        tree_points = filtered_points[filtered_labels == label]
        # 可以对树木点进行进一步处理，如提取树高、树冠范围等（树冠范围可补充本实验拓展）

tree_data = {
    'tree_id': [],
    'height': [],
    'crown_area': [],
    'volume': []
}

for label in unique_labels:
    if label != -1:
        tree_points = filtered_points[filtered_labels == label]
        height = np.max(tree_points[:, 2]) - np.min(tree_points[:, 2])
        crown_area = calculate_crown_area(tree_points)
        volume = calculate_tree_volume(tree_points)

        tree_data['tree_id'].append(label)
        tree_data['height'].append(height)
        tree_data['crown_area'].append(crown_area)
        tree_data['volume'].append(volume)

# 存为 CSV
tree_df = pd.DataFrame(tree_data)
tree_df.to_csv("tree_analysis_results.csv", index=False)


