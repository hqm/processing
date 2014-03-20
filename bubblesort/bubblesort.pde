int a[] = {
  5, 7, 4, 2, 8, 1
};
void bubblesort(int b[]) {
  for (int n = 0; n<b.length-1; n++) {
    bubblesortinternal(b);
  }
}


void bubblesortinternal(int b[]) {
  for (int i = 0; i<b.length-1; i++) {
    int n1 = b[i];
    int n2 = b[i+1];
    if (n1>n2) {
      b[i] = n2;
      b[i+1] = n1;
    }
  }
}




void setup() {
  bubblesort(a);
  println(a);
}

