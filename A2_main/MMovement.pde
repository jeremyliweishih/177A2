/*----------------------------------------------------------------
  Partners: Jeremy Shih and Vivian Chen
  COMP177: Visualization Assignment 2
  
  Functions related to all client interactions
/*----------------------------------------------------------------*/
void mouseDragged(){
 for (Node n : nodes.values()) {
     if(n.mouseOver()){
       n.position[0] = mouseX;
       n.position[1] = mouseY;
     }
 }
 float f = 1; 
 
 //need to add check if out of bound on bar
 for(int i = 0; i < All_Sl.size(); i++){
   if(All_Sl.get(i).mouseOver){
     Slider s = All_Sl.get(i);
     //when dragging left
     if(mouseX - pmouseX < 0)
     {
       s.sh_x = s.sh_x - f;
       float d_f = sscale.get(i) + scale_increment.get(i); //10 chosen as arb. num
       sscale.set(i, d_f);
     //when dragging right     
     } else if(mouseX - pmouseX > 0){
       s.sh_x = s.sh_x + f;
       float d_f = sscale.get(i) - scale_increment.get(i);
       sscale.set(i, d_f);
     }
   }
 }
 }