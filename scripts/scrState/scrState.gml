/// @func xState())
#macro MAX_STATE_HISTORY 10
function xState(_owner = other.id) constructor
{
	owner	= _owner;
	with (owner)
	{
		__state			= {};
		__states		= {};
		__defaults		= {};
		__states_array	= [];
		__history		= [];
	}
	static __update_history = function (name)
	{
		var l = array_length(owner.__history);
		array_push(owner.__history, name);
		if (l >= MAX_STATE_HISTORY)
		{
			array_pop(owner.__history);
		}
	}
	static default_before = function(func)
	{
		with(owner) 
		{
			__defaults[$ "before"] = func;
		}
		return self;		
	}	
	static default_after = function(func)
	{
		with(owner) 
		{
			__defaults[$ "after"] = func;
		}
		return self;		
	}
	static add	= function(name, struct)
	{
		with(owner) 
		{
			__states[$ name]			= struct;
			__states[$ name][$ "name"]	= name;
		}
		return self;
	}
	static init = function(name)
	{
		if (variable_struct_exists(owner.__state, "leave")) 
		{
			with owner
			{
				script_execute_ext(method_get_index(__state.leave), []);
			}
		}
		// Create an array includes all states names in a row when you init your state
	    var names = variable_struct_get_names(owner.__states)
	    var size = variable_struct_names_count(owner.__states);
		for (var i = 0; i < size; i++) 
		{
	        var ind = names[i];
	        var val = variable_struct_get(owner.__states, ind);
	        if (array_safe(owner.__states_array, val.name))
			{
	        	array_push(owner.__states_array, val.name);
			}
    	}
    	// Apply first state
		owner.__state = owner.__states[$ name];
		__update_history(name);
		if (variable_struct_exists(owner.__state, "enter")) 
		{
			with owner
			{
				script_execute_ext(method_get_index(__state.enter), []);
			}
		}
		return self;
	}
	static change = function(name, funcbef = function() {}, funcaft = function() {})
	{
		
		if (variable_struct_exists(owner.__states, name))
		{
			funcbef();
			if (variable_struct_exists(owner.__state, "leave")) 
			{
				with (owner)
				{
					script_execute_ext(method_get_index(__state.leave), []);
				}
			}
			owner.__state = owner.__states[$ name];
			__update_history(name);
			funcaft();
			if (variable_struct_exists(owner.__state, "enter")) 
			{
				with (owner)
				{
					script_execute_ext(method_get_index(__state.enter), []);
				}
			}
		}
		return self;
	}
	
	/// @function call(event_name))
	static call = function(name, _defaults = false)
	{
		if (_defaults)
		{
			with (owner)
			{
				script_execute_ext(method_get_index(__defaults[$ "before"]), []);
				script_execute_ext(method_get_index(__state[$ name]), []);
				script_execute_ext(method_get_index(__defaults[$ "after"]), []);
			}
		}
		else
		{
			with (owner)
			{
				script_execute_ext(method_get_index(__state[$ name]), []);
			}			
		}
		return self;
	}
	
	static get_state = function()
	{
		return owner.__state.name;
	}	
	
	static get_state_length = function()
	{
		var size = variable_struct_names_count(owner.__states);
		return size;
	}
	
	static get_state_array = function()
	{
		return owner.__states_array;
	}
	
	static get_state_history = function()
	{
		return owner.__history;
	}
}









