#include "tree.h"

int main(void) {
  /* Your Test Code Here */
  Tree t;
  t.num_nodes = 10;
  Tree *tp = &t;
  tp -> num_nodes++;
  printf("%d", tp -> num_nodes);
}
