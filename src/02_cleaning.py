import pandas as pd

df = pd.read_csv("data/samples/sample_5M.csv")

print(df.columns.tolist())
print(df.head())