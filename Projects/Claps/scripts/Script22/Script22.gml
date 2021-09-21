#region Data
function array_shuffled(arr)
{
	var len = array_length(arr);
	for (var i = 0; i < len; i++)
	{
		var r = irandom(len-1);
		
		var arr1 = arr[i];
		var arr2 = arr[r];
		
		arr[i] = arr2;
		arr[r] = arr1;
	}
	return arr;
}

function array_shuffle(arr)
{
	array_sort(arr, function() {
		return irandom_range(-1, 1);
	});
}

function array_reverse(arr)
{
	var l = array_length(arr);
	var a = array_create(l);
	var i = 0; repeat(l)
	{
		a[i] = arr[(l-1) - i];
		i++;
	}
	return a;
}

function array_safe(_array, _value)
{
	var i = 0; repeat(array_length(_array))
	{
		if (_array[i] == _value)
		{
			return false;
			break;
		}
		i++;
	}
	return true;
}

function ds_list_safe(_list, _value)
{
	var i = 0; repeat(ds_list_size(_list))
	{
		if (_list[| i] == _value)
		{
			return false;
			break;
		}
		i++;
	}
	return true;
}
#endregion

#region Foreach
#macro as , function
/// @function foreach(array as (element, [index])
function foreach(array, func) { 
    var size = array_length(array);
	ttt = method(self, func);
	for (var i = 0; i < size; i++) 
	{       
	    var element = array[i];
		with self
		{
			script_execute_ext(method_get_index(ttt), [element, i]);
		}
	}
}
//var arr = [0, 1, 2];
//var m = 2;
//foreach(arr as (ind, val) 
//{
//	show(val * m);
//});

/// @function foreach_list(list as (element, [index])
function foreach_list(list, func) {
    var size = ds_list_size(list);
    
    for (var i = 0; i < size; i++) {
        var element = list[| i];
        func(element, i);
    }
}

/// @function foreach_map(map as (element, [key], [index])
function foreach_map(map, func) {
    var size = ds_map_size(map);
    
    var key = ds_map_find_first(map);
    
    for (var i = 0; i < size; i++) {
        var element = map[? key];
        func(element, key, i);
        
        key = ds_map_find_next(map, key);
    }
}

/// @function foreach_stack(stack as (element, [index])
function foreach_stack(stack, func) {
    var size = ds_stack_size(stack);
    
    for (var i = 0; i < size; i++) {
        var element = ds_stack_pop(stack);
        func(element, i);
    }
}

/// @function foreach_queue(queue as (element, [index])
function foreach_queue(queue, func) {
    var size = ds_queue_size(queue);
    
    for (var i = 0; i < size; i++) {
        var element = ds_queue_dequeue(queue);
        func(element, i);
    }
}

/// @function foreach_priority(priority as (element, [key], [index])
function foreach_priority(priority, func) {
    var size = ds_priority_size(priority);
    
    for (var i = 0; i < size; i++) {
        var element = ds_priority_find_max(priority);
        var key = ds_priority_find_priority(priority, element);
        func(element, key, i);
        
        ds_priority_delete_max(priority);
    }
}

/// @function foreach_struct(struct as (element, [name], [index])
function foreach_struct(struct, func) {
    var names = variable_struct_get_names(struct)
    var size = variable_struct_names_count(struct);
    
    for (var i = 0; i < size; i++) {
        var name = names[i];
        var element = variable_struct_get(struct, name);
        func(element, name, i);
    }
}
#endregion

#region Functions
function draw_set_aling(halign, valign)
{
	draw_set_halign(halign);
	draw_set_valign(valign);
}

function draw_set_blend(color, alpha)
{
	draw_set_color(color);
	draw_set_alpha(alpha);
}

function lengthdir(len = new Vector2(0), dir = new Vector2(0)) 
{
	return new Vector2(lengthdir_x(len.x, dir.x), lengthdir_y(len.y, dir.y));
}

//Concatenate a series of arguments into a string
function concat() 
{
    var _string = "";
    for(var i = 0; i < argument_count; i++) _string += string(argument[i]);
    return _string;
}
 
//Show debug message enhanced with string concatenation
function debug_message()
{
    var _string = "";
    for(var i = 0; i < argument_count; i++) _string += string(argument[i]);
    show_debug_message(_string);
}

//Show debug message enhanced with string concatenation
function screen_message()
{
    var _string = "";
    for(var i = 0; i < argument_count; i++) _string += string(argument[i]);
    show_message(_string);
}

//Move value towards another value by a given amount
function approach(_a, _b, _amount) 
{
    if (_a < _b)
    {
        _a += _amount;
        if (_a > _b)
            return _b;
    }
    else
    {
        _a -= _amount;
        if (_a < _b)
            return _b;
    }
    return _a;
}
 
//Sine waves a value between two values over a given time. 
function wave(_from, _to, _duration, _offset) 
{
    var a4 = (_to - _from) * 0.5;
    return _from + a4 + sin((((current_time * 0.001) + _duration * _offset) / _duration) * (pi*2)) * a4; 
}
 
//Wraps a value between a minimum and a given wrap point
function wrap(_value, _minimum, _wrapAt) 
{
 
    var _mod = ( _value - _minimum ) mod ( _wrapAt - _minimum );
    if ( _mod < 0 ) return _mod + _wrapAt else return _mod + _minimum;
}

function normalize_value(value, min, max)
{
	var normalized = (value - min) / (max - min);
	normalized = clamp(normalized, 0, 1);
	return normalized;
}

///Map(val, min1, max1, min2, max2)   
function remap(value, min1, max1, min2, max2)
{
	/*      
	value = 110;      
	m = Map(value, 0, 100, -20, -10);      
	// m = -9      
	*/
	return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
}

/// @description
/// @description Chance(percent)
/// @param percent
function chance(_percent)
{
	// Returns true or false depending on RNG
	// ex: 
	//		Chance(0.7);	-> Returns true 70% of the time
	return _percent > random(1);
}

// Finite lerp function
function flerp(val1, val2, amount, epsilon = EPSILON)
{
	return abs(val1 - val2) > epsilon ? lerp(val1, val2, amount) : val2;
}

#endregion

#region Constructors
function Typewriter(_text, _spd = 0.25) constructor
{
	text	= _text;
	char	= 1;
	charSpd = _spd;
	len		= string_length(text);
	static write = function(_text = text)
	{
		if (text != _text)
		{
			text = _text;
			len		= string_length(text);
		}
		if (char < len)
		{
			char += charSpd;
		}
		return string_copy(text, 1, char);
	}
	static reset = function(_text = text)
	{
		text = _text;
		char = 1;
	}
}
#endregion
