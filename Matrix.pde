class Matrix {
  float[][] matrix;
  int m_height;
  int m_width;
  
  Matrix(float[][] matrix, int h, int w){
    this.matrix = matrix;
    this.m_width = w;
    this.m_height = h;
  }
  
  Matrix(float[][] matrix, int square){
    this.matrix = matrix;
    this.m_width = square;
    this.m_height = square;
  }
  
  float[][] getMatrix(){ return matrix; }
  
  float getValue(int i, int j){
    return matrix[i][j];
  }
  
  void setValue(int i, int j, float value){
    matrix[i][j] = value;
  }
  
  void setLine(int i, float[] new_line){
    matrix[i] = new_line;
  }
  
  void setColumn(int j, float[] new_column){
    for (int i = 0; i < m_height; i++) matrix[i][j] = new_column[i];
  }
  
  int getHeight(){
    return m_height;
  }
  
  int getWidth(){
    return m_width;
  }
  
  Matrix transposed(){
    int t_width = m_height;
    int t_height = m_width;
    Matrix t_matrix = new Matrix(matrix, t_height, t_width);
    for(int j = 0; j < m_width; j++){
      t_matrix.setLine(j,new float[m_height]);
      for(int i = 0; i < m_height; i++){
        t_matrix.setValue(i, j, matrix[i][j]);
      }
    }
    return t_matrix; //<>//
  }
  
  
}
