#include <stdio.h>


#define MATRIX_ROWS 3
#define MATRIX_COLUMNS 3

void printMatrix(int matrix[MATRIX_ROWS][MATRIX_COLUMNS]) {
    for (int i = 0; i < MATRIX_ROWS; i++) {
        for (int j = 0; j < MATRIX_COLUMNS; j++) {
            printf("%d ", matrix[i][j]);
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

void matrixMultOptmized(int matrix_A[MATRIX_ROWS][MATRIX_COLUMNS],
                int matrix_B[MATRIX_ROWS][MATRIX_COLUMNS],
                int matrix_C[MATRIX_ROWS][MATRIX_COLUMNS]) {
    int i=0;
    while(i<MATRIX_ROWS) {
        int j=0;
        while(j<MATRIX_COLUMNS) {
            matrix_C[i][j] = 0;
            int k=0;
            // Do entire row*col multiplication
            matrix_C[i][j] += matrix_A[i][k+0] * matrix_B[k+0][j];
            matrix_C[i][j] += matrix_A[i][k+1] * matrix_B[k+1][j];
            matrix_C[i][j] += matrix_A[i][k+2] * matrix_B[k+2][j];
            j++;
        }
        i++;
    }
}


int main() {
    int rows = MATRIX_ROWS;
    int cols = MATRIX_COLUMNS;
    int matrix_A[MATRIX_ROWS][MATRIX_COLUMNS] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
    int matrix_B[MATRIX_ROWS][MATRIX_COLUMNS] = {{9, 8, 7}, {6, 5, 4}, {3, 2, 1}};
    int matrix_C[MATRIX_ROWS][MATRIX_COLUMNS];
    printMatrix(matrix_A);
    printf("\nTIMES\n\n");
    printMatrix(matrix_B);
    matrixMultOptmized(matrix_A, matrix_B, matrix_C);
    printf("\nRESULT\n\n");
    printMatrix(matrix_C);
    return 0;
}