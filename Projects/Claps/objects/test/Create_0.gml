t = new xTimer()
fsm = new xState("0");

// fsm.add("0", {
// 	enter: function()
// 	{
// 		t.start(120);
// 	},
// 	step: function()
// 	{
// 		t.on_timeout(function()
// 		{
// 			fsm.change("1", function()
// 			{
// 				t.reset();
// 				here;
// 			})
// 		})
// 	}
// })

// fsm.add("1", {
// 	enter: function()
// 	{
// 		show("i am at 1");
// 		t.reset();
// 		t.start(300);
// 	},
// 	step: function()
// 	{
// 		t.on_timeout(function()
// 		{
// 			here;
// 			fsm.change("0", function()
// 			{
// 				t.reset();
// 				show("i am going to be a zero");
// 			})
// 		})
// 	}
// })

// fsm.add("2", {
// 	enter: function()
// 	{
// 		show(fsm.get_state_history());
// 		fsm.change("0", function()
// 		{
// 			show("switched");
// 		});
		
// 	}
// })

// fsm.init("0");


// fsm = new SnowState("0");

// fsm.add("0", {
// 	enter: function()
// 	{
// 		fsm.change("1", function()
// 		{
// 			show("switched");
// 		});
// 	},
// 	step: function()
// 	{
// 		here;
// 	}
// })

// fsm.add("1", {
// 	enter: function()
// 	{
// 		fsm.change("2", function()
// 		{
// 			show("switched");
// 		});
// 	}
// })

// fsm.add("2", {
// 	enter: function()
// 	{
// 		show(fsm.get_state_history());
// 		fsm.change("0", function()
// 		{
// 			show("switched");
// 		});
		
// 	}
// })
