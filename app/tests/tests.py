import pytest
from batch_play import main

@pytest.mark.parametrize("a,b,expected",[(10, 5, 15),(-1, 1, 0),(-1, -1, -2)])
def test_add(a, b, expected):
	assert main.add(a, b) == expected

@pytest.mark.parametrize("file, expected", [("/data/my-data.xlsx", 9)])
def test_get_file(file, expected):
	data = main.get_data(file)
	assert data.shape[0] == expected
