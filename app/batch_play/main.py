import pandas as pd

def add(x, y):
    """Add Function"""
    return x + y

def get_data(file: str):
    return pd.read_excel(file)


if __name__ == '__main__':
    print("Version 1:")
    data = get_data("/data/my-data.xlsx")
    print(data)
