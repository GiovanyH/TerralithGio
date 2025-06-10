cabeca = instance_create_layer(x, y, "Instances", obj_FuraTobaCbc);

velocity = 7;

wait_time = 20;
current_wait_time = 0;

following = false;

old_pos = new vector(0, 0);

max_distance = 200;

pos_to_follow = new vector(0, 0);

dir_vect = new vector(0, 0);

move_x = 0;
move_y = 0;