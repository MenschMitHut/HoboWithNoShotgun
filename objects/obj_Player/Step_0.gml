/// @description Movement

shoot_was_pressed = keyboard_check_pressed(vk_control);
walk_left_is_pressed = keyboard_check(vk_left);
walk_right_is_pressed = keyboard_check(vk_right);
jump_was_pressed = keyboard_check_pressed(vk_space);
var movement_key_is_pressed = walk_left_is_pressed || walk_right_is_pressed;

switch(current_player_state)
{
	case PlayerState.Idle:
	{
		if(was_hit)
		{
			scr_PlayerHit();
			break;
		}
		if(shoot_was_pressed)
		{
			scr_PlayerAttack();
		}
		else if (jump_was_pressed)
		{
			scr_PlayerJump();
		}
		else if(movement_key_is_pressed)
		{
			scr_PlayerUpdateRotation();
			scr_PlayerWalk();
		}		
		break;
	}
	case PlayerState.Walk:
	{
		if(was_hit)
		{
			scr_PlayerHit();
			break;
		}
		
		if(shoot_was_pressed)
		{
			scr_PlayerAttack();
		}
		else if(jump_was_pressed)
		{
			scr_PlayerJump();
		}
		else if(movement_key_is_pressed)
		{
			scr_PlayerUpdateRotation();
			scr_PlayerWalkUpdate();
		}		
		else
		{
			scr_PlayerIdle();
		}
		break;
	}
	case PlayerState.Attack:
	{
		if(was_hit)
		{
			scr_PlayerHit();
			break;
		}
		scr_PlayerAttackUpdate();
		if(image_index > image_number -1)
		{
			if(shoot_was_pressed)
			{
				scr_PlayerAttack();
			}
			else if(jump_was_pressed)
			{
				scr_PlayerJump();
			}
			else if(movement_key_is_pressed)
			{
				scr_PlayerUpdateRotation();
				scr_PlayerWalk();
			}			
			else 
			{
				scr_PlayerIdle();
			}
		}		
		break;
	}
	case PlayerState.Jump:
	{
		if(was_hit)
		{
			if(is_in_air)
			{
				scr_PlayerAirborneHit();
			}
			else 
			{
				scr_PlayerHit();
			}			
			break;
		}
		scr_PlayerJumpUpdate();
		if(has_jumped && (image_index > 1))
		{
			scr_PlayerIdle();
		}
		break;
	}
	case PlayerState.Hit:
	{
		if(was_hit)
		{
			scr_PlayerHit();
			break;
		}
		if(image_index > image_number -1)
		{
			if(shoot_was_pressed)
			{
				scr_PlayerAttack();
			}
			else if(jump_was_pressed)
			{
				scr_PlayerJump();
			}
			else if(movement_key_is_pressed)
			{
				scr_PlayerUpdateRotation();
				scr_PlayerWalk();
			}
			else 
			{
				scr_PlayerIdle();
			}
		}		
		break;
	}
	case PlayerState.AirbornHit:
	{
		scr_PlayerAirborneHitUpdate();
		if(!is_in_air)
		{
			scr_PlayerIdle();
		}
		break;
	}
	case PlayerState.Dying:
	{
		scr_PlayerDieUpdate();
	}
}

if(hp <= 0 && !is_dying && !is_in_air) 
{
	scr_PlayerDie();
}

var view_left = camera_get_view_x(view_camera[0]);
var view_right = view_left + camera_get_view_width(view_camera[0]);
var border_distance = 20;

if(x < view_left + border_distance)
{
	x = view_left + border_distance;
}

if (x > view_right - border_distance)
{
    x = view_right - border_distance;
}
