int a[] = {
  5, 7, 4, 2, 8
};
void mysort(int b[]) {
  for(int i = 0; i < b.length; i++){
    mysort2(b, i, b.length-1);
  }
}
void mysort2(int b[], int start, int end) {
  int min = b[start];
  int minIndex = start;
  for (int i = start; i <= end; i++) {
    if (b[i]<min) {
      min = b[i];
      minIndex = i;
    }
  }
  int c = b[start];
  b[start] = b[minIndex];
  b[minIndex]=c;
  println(b);
  println("***");
}
void setup(){
  mysort(a);
 
}
