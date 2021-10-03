case "$MODEL" in
	ylm,rg350*)
		# RG-350 / RG-350M: two clickable analog sticks
		SDL_JOYSTICK_TRANSLATOR_MAP='OpenDingux Virtual Device,axis:190000006a6f79737469636b00000000:0,axis:190000006a6f79737469636b00000000:1,axis:190000006a6f79737469636b00000000:2,axis:190000006a6f79737469636b00000000:3,btn:kb:224,btn:kb:226,btn:kb:225,btn:kb:44,btn:kb:40,btn:kb:41,btn:kb:43,btn:kb:42,btn:kb:75,btn:kb:78,btn:kb:84,btn:kb:99,hat:kb:82:79:81:80'
		SDL_GAMECONTROLLERCONFIG='4f70656e44696e677578204743572d5a,OpenDingux Virtual Device,platform:Linux,a:b1,b:b0,x:b2,y:b3,back:b5,start:b4,leftstick:b10,rightstick:b11,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9'
		;;
	ylm,rg280m)
		# RG-280M: One clickable analog stick
		SDL_JOYSTICK_TRANSLATOR_MAP='OpenDingux Virtual Device,axis:190000006a6f79737469636b00000000:0,axis:190000006a6f79737469636b00000000:1,btn:kb:224,btn:kb:226,btn:kb:225,btn:kb:44,btn:kb:40,btn:kb:41,btn:kb:43,btn:kb:42,btn:kb:75,btn:kb:78,btn:kb:84,hat:kb:82:79:81:80'
		SDL_GAMECONTROLLERCONFIG='4f70656e44696e677578204743572d5a,OpenDingux Virtual Device,platform:Linux,a:b1,b:b0,x:b2,y:b3,back:b5,start:b4,leftstick:b10,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9'
		;;
	gcw,zero|wolsen,pocketgo2*)
		# GCW-Zero, PocketGo2/PlayGo: One non-clickable analog stick
		SDL_JOYSTICK_TRANSLATOR_MAP='OpenDingux Virtual Device,axis:190000006a6f79737469636b00000000:0,axis:190000006a6f79737469636b00000000:1,btn:kb:224,btn:kb:226,btn:kb:225,btn:kb:44,btn:kb:40,btn:kb:41,btn:kb:43,btn:kb:42,btn:kb:75,btn:kb:78,hat:kb:82:79:81:80'
		SDL_GAMECONTROLLERCONFIG='4f70656e44696e677578204743572d5a,OpenDingux Virtual Device,platform:Linux,a:b1,b:b0,x:b2,y:b3,back:b5,start:b4,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,leftx:a0,lefty:a1,rightx:a2,righty:a3,lefttrigger:b8,righttrigger:b9'
		;;
	img,ci20)
		# CI20: Don't create a gamepad
		;;
	ylm,rg280v|qishenglong,gopher2*)
		# RG-280V, Gopher2: No analog stick, with L2/R2
		SDL_JOYSTICK_TRANSLATOR_MAP='OpenDingux Virtual Device,btn:kb:224,btn:kb:226,btn:kb:225,btn:kb:44,btn:kb:40,btn:kb:41,btn:kb:43,btn:kb:42,btn:kb:75,btn:kb:78,hat:kb:82:79:81:80'
		SDL_GAMECONTROLLERCONFIG='4f70656e44696e677578204743572d5a,OpenDingux Virtual Device,platform:Linux,a:b1,b:b0,x:b2,y:b3,back:b5,start:b4,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2,lefttrigger:b8,righttrigger:b9'
		;;
	*)
		# Default: No analog stick, without L2/R2
		SDL_JOYSTICK_TRANSLATOR_MAP='OpenDingux Virtual Device,btn:kb:224,btn:kb:226,btn:kb:225,btn:kb:44,btn:kb:40,btn:kb:41,btn:kb:43,btn:kb:42,hat:kb:82:79:81:80'
		SDL_GAMECONTROLLERCONFIG='4f70656e44696e677578204743572d5a,OpenDingux Virtual Device,platform:Linux,a:b1,b:b0,x:b2,y:b3,back:b5,start:b4,leftshoulder:b6,rightshoulder:b7,dpup:h0.1,dpdown:h0.4,dpleft:h0.8,dpright:h0.2'
		;;
esac
