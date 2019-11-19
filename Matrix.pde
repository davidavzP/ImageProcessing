class Matrix {
  float[][] matrix;
  int m_width;
  int m_height;
  
  Matrix(float[][] matrix, int w, int h){
    this.matrix = matrix;
    this.m_width = w;
    this.m_height = h;
  }
  
  Matrix(float[][] matrix, int square){
    this.matrix = matrix;
    this.m_width = square;
    this.m_height = square;
  }
  
  float get(int i, int j){
    return matrix[i][j];
  }
  
  int getHeight(){
    return m_height;
  }
  
  int getWidth(){
    return m_width;
  }
  
  
  
  
}
