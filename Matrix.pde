class Matrix {
  float[][] matrix;
  int m_height;
  int m_width;
  
  Matrix(int square){
    float[][] values = new float[square][square];
    for (int i = 0; i < square; i++){
      for (int j = 0; j < square; j++){
        values[i][j] = 0;
      }
    }
    this.matrix = values;
    this.m_width = this.m_height = square;
  }
  
  Matrix(int h, int w){
    float[][] values = new float[h][w];
    for (int i = 0; i < h; i++){
      for (int j = 0; j < w; j++){
        values[i][j] = 0;
      }
    }
    this.matrix = values;
    this.m_width = w;
    this.m_height = h;
  }
  
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
  
  Matrix transposed(Matrix matrix){
    int t_width = matrix.getHeight();
    int t_height = matrix.getWidth();
    Matrix t_matrix = new Matrix(t_height, t_width);
    for(int i = 0; i < t_height; i++){
      t_matrix.setLine(i,new float[t_width]);
      for(int j = 0; j < t_width; j++){
        t_matrix.setValue(i, j, matrix.getValue(j,i));
      }
    }
    return t_matrix; //<>// //<>//
  }
  
  
}
