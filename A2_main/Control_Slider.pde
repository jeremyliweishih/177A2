public class Slider{
  float position[] = new float[2]; // index 0 is xpos, 1 is ypos
  float w;
  float h;
  float min; //min point where slider can go
  float max; //max point where slider can go
  int id; //temporary addition for debugging
 
 //label related components
  String label;
  float t_size;
  float l_x;
  float l_y;
  
 //slider hand related components
  color c;
  float sh_x;
  float sh_y;
  float sh_w;
  float sh_h;
  boolean mouseOver;
  
  public Slider(int i,String l, float x, float y, float wi, float hi){
       label = l;
       position[0] = x;
       position[1] = y;
       w = wi;
       h = hi;
       mouseOver = false;
       min = x;
       max = x + wi - 15;
       id  = i; //temporary addition for debugging
  }
  public void setLabelinfo(float x, float y, float t_sz) {
    l_x = x;
    l_y = y;
    t_size = t_sz;
  }
  public void drawSlider(){
    fill(0);
    rect(position[0] , position[1] , w , h);     
    drawLabel();
  }
  
  void drawLabel(){
    textSize(t_size);
    textAlign(LEFT);
    text(label, l_x, l_y);
  }
  
  public void setSlHand(color col, float x, float y, float w, float h){
    sh_x = x;
    sh_y = y;
    sh_w = w;
    sh_h = h;
    c = col;
    //drawSliderHand();
  }
  public void drawSliderHand(){  
    fill(c);
    float curr_x = sh_x;
    if(curr_x <= min){
      sh_x = min;
    } 
    if(curr_x >= max){
      print("LOL");
      sh_x = max;
    }
    rect(sh_x, sh_y, sh_w, sh_h);
    checkMO();
  }
  void checkMO(){
    float x_max = sh_x + sh_w;
    float y_max = sh_y + sh_h;
     if(mouseX >= sh_x && mouseX <= x_max && mouseY >= sh_y &&  mouseY <= y_max)
     {
       println("id: " + id);
        mouseOver = true; 
     }
  }
}