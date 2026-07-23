import pandas as pd

df = pd.read_csv(
    "data/raw/userbehavior/UserBehavior.csv",
    nrows=5
)

print(df.columns.tolist())
print(df.head())
