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