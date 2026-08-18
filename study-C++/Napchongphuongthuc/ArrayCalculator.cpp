#include <iostream>

using namespace std;
class ArrayCalculator {
public:
	static int maxOfArray(int arr[], int n) {
		int maxValue = arr[0];
		for (int i = 1; i < n; i++) {
			if (arr[i] > maxValue) {
				maxValue = arr[i];
			}
		}
		return maxValue;
	}

	static double maxOfArray(double arr[], int n) {
		double maxValue = arr[0];
		for (int i = 1; i < n; i++) {
			if (arr[i] > maxValue) {
				maxValue = arr[i];
			}
		}
		return maxValue;
	}

	static int minOfArray(int arr[], int n) {
		int minValue = arr[0];
		for (int i = 1; i < n; i++) {
			if (arr[i] < minValue) {
				minValue = arr[i];
			}
		}
		return minValue;
	}

	static double minOfArray(double arr[], int n) {
		double minValue = arr[0];
		for (int i = 1; i < n; i++) {
			if (arr[i] < minValue) {
				minValue = arr[i];
			}
		}
		return minValue;
	}
};

int main() {
	int arr1[] = { 3, 4, 2 };	
	double arr2[] = { 1.3, 4.2, 6.7 };

	cout << ArrayCalculator::minOfArray(arr1, sizeof(arr1) / sizeof(int)) << endl;
	cout << ArrayCalculator::minOfArray(arr2, sizeof(arr2) / sizeof(double)) << endl;
	cout << ArrayCalculator::maxOfArray(arr1, sizeof(arr1) / sizeof(int)) << endl;
	cout << ArrayCalculator::maxOfArray(arr2, sizeof(arr2) / sizeof(double)) << endl;
	return 0;
}
