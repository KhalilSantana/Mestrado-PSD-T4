#include <stdio.h>


#define MATRIX_ROWS 3
#define MATRIX_COLUMNS 3

void printMatrix(int matrix[MATRIX_ROWS][MATRIX_COLUMNS]) {
    for (int i = 0; i < MATRIX_ROWS; i++) {
        for (int j = 0; j < MATRIX_COLUMNS; j++) {
            printf("%2d ", matrix[i][j]);
        }
        printf("\n");
    }
}

void matrixMult(int matrix_A[MATRIX_ROWS][MATRIX_COLUMNS],
                int matrix_B[MATRIX_ROWS][MATRIX_COLUMNS],
                int matrix_C[MATRIX_ROWS][MATRIX_COLUMNS]) {
    int i=0;
    while(i<MATRIX_ROWS) {
        int j=0;
        while(j<MATRIX_COLUMNS) {
            matrix_C[i][j] = 0;
            int k=0;
            while(k<MATRIX_COLUMNS) {
                matrix_C[i][j] += matrix_A[i][k] * matrix_B[k][j];
                k++;
            }
            j++;
        }
        i++;
    }
}


int main() {
    int matrix_A[MATRIX_ROWS][MATRIX_COLUMNS] = {{0, 1, 2}, {3, 4, 5}, {6, 7, 8}};
    int matrix_B[MATRIX_ROWS][MATRIX_COLUMNS] = {{2, 5, 6}, {3, 8, 7}, {4, 1, 0}};
    int matrix_C[MATRIX_ROWS][MATRIX_COLUMNS];
    printMatrix(matrix_A);
    printf("\nTIMES\n\n");
    printMatrix(matrix_B);
    matrixMult(matrix_A, matrix_B, matrix_C);
    printf("\nRESULT\n\n");
    printMatrix(matrix_C);
    return 0;
}