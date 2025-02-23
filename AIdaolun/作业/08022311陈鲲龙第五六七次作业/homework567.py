import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import GridSearchCV
from sklearn.tree import DecisionTreeClassifier
from sklearn.ensemble import RandomForestClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import LabelEncoder
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False
train_data = pd.read_csv('dna.scale.tr', header=None, sep=' ', names=['class'] + [f'feature_{i}' for i in range(1, 181)])
val_data = pd.read_csv('dna.scale.val', header=None, sep=' ', names=['class'] + [f'feature_{i}' for i in range(1, 181)])
test_data = pd.read_csv('dna.scale.t', header=None, sep=' ', names=['class'] + [f'feature_{i}' for i in range(1, 181)])
def preprocess(data):
    X = []
    y = []
    for index, row in data.iterrows():
        y.append(int(row['class']))
        features = row[1:].values
        feature_dict = {}
        for feature in features:
            if pd.notna(feature):
                try:
                    idx, val = str(feature).split(':')
                    feature_dict[int(idx)] = int(val)
                except ValueError:
                    print(f"Skipping invalid feature format: {feature}")
        X.append([feature_dict.get(i, 0) for i in range(180)])
    return np.array(X), np.array(y)
X_train, y_train = preprocess(train_data)
X_val, y_val = preprocess(val_data)
X_test, y_test = preprocess(test_data)
le = LabelEncoder()
y_train = le.fit_transform(y_train)
y_val = le.transform(y_val)
y_test = le.transform(y_test)
dt_model = DecisionTreeClassifier(random_state=42)
rf_model = RandomForestClassifier(random_state=42)
nb_model = GaussianNB()
svm_model = SVC(random_state=42)
dt_model.fit(X_train, y_train)
y_train_pred_dt = dt_model.predict(X_train)
y_test_pred_dt = dt_model.predict(X_test)
rf_model.fit(X_train, y_train)
y_train_pred_rf = rf_model.predict(X_train)
y_test_pred_rf = rf_model.predict(X_test)
nb_model.fit(X_train, y_train)
y_train_pred_nb = nb_model.predict(X_train)
y_test_pred_nb = nb_model.predict(X_test)
svm_model.fit(X_train, y_train)
y_train_pred_svm = svm_model.predict(X_train)
y_test_pred_svm = svm_model.predict(X_test)
train_errors = {
    'Decision Tree': 1 - accuracy_score(y_train, y_train_pred_dt),
    'Random Forest': 1 - accuracy_score(y_train, y_train_pred_rf),
    'Naive Bayes': 1 - accuracy_score(y_train, y_train_pred_nb),
    'SVM': 1 - accuracy_score(y_train, y_train_pred_svm)
}
test_errors = {
    'Decision Tree': 1 - accuracy_score(y_test, y_test_pred_dt),
    'Random Forest': 1 - accuracy_score(y_test, y_test_pred_rf),
    'Naive Bayes': 1 - accuracy_score(y_test, y_test_pred_nb),
    'SVM': 1 - accuracy_score(y_test, y_test_pred_svm)
}
print("训练错误率：", train_errors)
print("测试错误率：", test_errors)
models = ['Decision Tree', 'Random Forest', 'Naive Bayes', 'SVM']
train_errors_vals = list(train_errors.values())
test_errors_vals = list(test_errors.values())
x = np.arange(len(models))
width = 0.35
fig, ax = plt.subplots()
rects1 = ax.bar(x - width/2, train_errors_vals, width, label='训练错误率')
rects2 = ax.bar(x + width/2, test_errors_vals, width, label='测试错误率')
ax.set_xlabel('模型')
ax.set_ylabel('错误率')
ax.set_title('不同模型的训练与测试错误率对比')
ax.set_xticks(x)
ax.set_xticklabels(models)
ax.legend()
fig.tight_layout()
plt.show()