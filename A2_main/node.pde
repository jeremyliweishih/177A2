class Node{
    double mass;
    double id;
    ArrayList c_nodes;
    ArrayList springs;
    
    Double[] accel = new Double[2];
    Double[] velocity = new Double[2];
    Double[] position = new Double[2];

    public Node(double m, double v){
       mass = m;
       value = v;
    }
    
    public void addEdge(double i, double l){
        c_nodes.add(i);
        springs.add(l);
    }
}