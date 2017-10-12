/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Functions for all force related calculations
/*----------------------------------------------------------------*/
void cal_coloumbs(HashMap<Integer, Node> nodes){
  float k2 = 10;
  for(Node n : nodes.values()){
  // compute coulumb force contribution 
      for( Node other_node : nodes.values()){
       if(n == other_node){
            continue; 
         }
        if (other_node.getId() != n.getId()){
        float distance = n.distance_from(other_node);
        
        float col_force = k2 / (distance * distance); // Coulombs Law f = k2/dist where k2 is defin);
        
        println(">> " + col_force);
        //if(col_force >= 1000)
        //{
        //   col_force = 100; 
        //}
        float[] direction = new float[2];
      
        direction[0] = -(other_node.position[0]- n.position[0]);
        direction[1] = -(other_node.position[1]- n.position[1]);
        
        direction = normalize(direction);
        
        float[] force = new float[2];
        force[0] = direction[0] * col_force;
        force[1] = direction[1] * col_force;
          //f = m * a
        float[] accel = new float[2];
          accel[0] = force[0] / n.mass;
          accel[1] = force[1] / n.mass;
   
          //add force to node acceleration
          n.accel[0] += accel[0];
          n.accel[1] += accel[1];
        }
      }
  }
}

void maintain_init_l(HashMap<Integer, Node> nodes) {
  float maintain_f = 2; 
  for(Node n : nodes.values()){
      for( int i = 0; i < n.c_nodes.size(); i ++){
        float init_len = n.springs.get(i);

        //get child information
        int child_id = n.c_nodes.get(i);
        Node child = nodes.get(child_id);
        
        //get curr distance between parent and child
        float curr_dist = n.distance_from(child);
  
        if(curr_dist - init_len >= 1) {
          float[] direction = new float[2];
          direction[0] = -(child.position[0]- n.position[0]);
          direction[1] = -(child.position[1]- n.position[1]);
          direction = normalize(direction);
          
          //update child position given constant force and direction
          child.position[0] += direction[0] * maintain_f;
          child.position[1] += direction[1] * maintain_f;
        }
      }
  }
}


void cal_hookes(HashMap<Integer, Node> nodes){
    float k1 = 1000;
    for(Node n : nodes.values()){
        for(Node other_node : nodes.values()){
         if(n == other_node){
            continue; 
         } 
         float distance = n.distance_from(other_node);
         
         if(distance == 0) {
           distance = 10;
         }
         
         float spring_length = n.getSpring(other_node);
         float delta_length = spring_length - distance;
         println("dl: " + delta_length);
         float hforce = k1 * delta_length;
         
         float[] direction = new float[2]; 
         direction[0] = -(other_node.position[0]- n.position[0]);
         direction[1] = -(other_node.position[1]- n.position[1]);
         
         if(Double.isNaN((double)direction[0])){
             direction[0] = n.mass;
         }
         if(Double.isNaN((double)direction[1])){
             direction[1] = n.mass;
         }
         
         //direction = normalize(direction);
         
         float[] force = new float[2];
         force[0] = direction[0] * hforce;
         force[1] = direction[1] * hforce;
   
         float[] accel = new float[2];
         accel[0] = force[0] / n.mass;
         accel[1] = force[1] / n.mass;
     }
    }
}


float[] normalize(float[] direction){
  float l = (float)(Math.sqrt(direction[0] * direction[0] + direction[1] * direction[1]));
  direction[0] = direction[0] / l;
  direction[1] = direction[1] / l;
  return direction;
}