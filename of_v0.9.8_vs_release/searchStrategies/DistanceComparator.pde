import java.util.Comparator;

// the distance comparator is needed to implement the priority queue for greedy search and A* search

class DistanceComparator implements Comparator<GridElement> {
  @Override
    public int compare(GridElement x, GridElement y) {
    if (x.costs < y.costs) {  // compare costs which are a object variable of GridElement
      return -1;
    } else if (x.costs > y.costs) {
      return 1;
    }
    return 0;
  }
}