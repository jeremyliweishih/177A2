/*----------------------------------------------------------------
  Functions for all force related calculations
/*----------------------------------------------------------------*/
void cal_coloumbs(HashMap<Integer, Node> nodes){
  float distance = 0;
  //float acc = 0;
  float col_force = 0;
  //float d_l = 0;
  //float k = 1;
  float k2 = 1;
 
  for(Node n : nodes.values()){
  // compute coulumb force contribution 
      for( Node other_node : nodes.values()){
        if (other_node.getId() != n.getId())
        {
          distance = n.distance_from(other_node); 
          col_force = k2/distance; // Coulombs Law f = k2/dist where k2 is defined
          //store all coulumb forces
          n.coulumb_forces.put((int)other_node.getId(), col_force);
        }
      }
      n.add_sprforce(nodes);
  }
}
void cal_acc(HashMap<Integer, Node> nodes){
  for(Node n : nodes.values()){
    
  }
  
}
// PRINT TEST FOR COULUMB FORCES
//void testc( Node n)
//{
//  for(int id : n.coulumb_forces.keySet()){
//     println("id: " + id + "sum: " + n.coulumb_forces.get(id));
//  }
//}
//void test(Node n)
//{
//  println("SPRINGS: ");
//   for ( int i = 0; i < n.springs.size(); i++)
//   {
//     println("id: " + n.c_nodes.get(i) + " " + n.springs.get(i)); 
//   }
//   println("C_FORCES: ");
//   for(int id : n.coulumb_forces.keySet()){
//     println("id: " + id + "v: " + n.coulumb_forces.get(id));
//   }
//}
      //}
      //for( int i = 0 ; i < n.springs.size(); i++) {
      //  distance = n.distance_from(n.c_nodes.get(i), nodes); 
      //  d_l = Math.abs(n.springs.get(i) - distance); //spring val - length
      //  col_force = k * d_l;     // F = k * D_L, where k is defined
      //  //compute acceleration
      //  acc = col_force/n.mass;  // f = m * a, where we know f & m
      //  print(acc);
        //computer velocity