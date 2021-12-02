application_surface_enable(false);
// game_width, game_height are your base resolution (ideally constants)
following = noone;
Follow = function(_id = self.id)
{
	/// @func Follow(id)
	self.following = _id;
}
game_width = camera_get_view_width(VIEW);
game_height = camera_get_view_height(VIEW);
scale = 3;
// in GMS1, set view_wview and view_hview instead
//camera_set_view_size(VIEW, game_width, game_height);
surface_resize(application_surface, game_width, game_height);
CAMERA.SetSize(game_width + 1, game_height + 1);
GUI.SetSize(game_width, game_height);
WINDOW.SetSize(game_width*scale, game_height*scale);
view_surf = -1;

//shake
shake			= false;
shake_time		= 0;
shake_magnitude = 0;
shake_fade		= 0;
ApplyScreenShake = function () 
{
	if (shake)
	{
		//reduce shake time by 1(every step)
		shake_time -= 1;
			
		//calculate shake magnitude
		var _xval = random_range(-shake_magnitude, shake_magnitude); 
		var _yval = random_range(-shake_magnitude, shake_magnitude);
			
		//apply the shake
		x += _xval;
		y += _yval;
			
		if (shake_time <= 0) 
		{
			//if shake time is zero, shake fade
			shake_magnitude -= shake_fade; 

			if (shake_magnitude <= 0) 
			{
				//if shake fade is zero, turn shake of
			    shake = false; 
			} 
		}
	}
}
Shake = function(_time, _magnitude, _fade = _magnitude)
{
	self.shake_time = _time;
	self.shake_magnitude = _magnitude;
	self.shake_fade = _fade;
	self.shake = true;
}