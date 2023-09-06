printh("Hello", "games/log", true)
local g = {lives = 3, score = 0, paddle_x = 52, paddle_y = 122, paddle_width = 24, paddle_height = 4, ball_x = 64, ball_y = 64, ball_size = 3, ball_x_direction = 5, ball_y_direction = -3}
local function move_paddle()
  if btn(0) then
    g["paddle_x"] = (g.paddle_x - 3)
    return nil
  elseif btn(1) then
    g["paddle_x"] = (g.paddle_x + 3)
    return nil
  else
    return nil
  end
end
local function move_ball()
  g["ball_x"] = (g.ball_x + g.ball_x_direction)
  do end (g)["ball_y"] = (g.ball_y + g.ball_y_direction)
  return nil
end
local function bounce_ball()
  if ((g.ball_x < g.ball_size) or (g.ball_x > (128 - g.ball_size))) then
    g["ball_x_direction"] = ( - g.ball_x_direction)
    sfx(0)
  else
  end
  if (g.ball_y < g.ball_size) then
    g["ball_y_direction"] = ( - g.ball_y_direction)
    return sfx(0)
  else
    return nil
  end
end
local function bounce_paddle()
  if ((g.ball_x >= g.paddle_x) and (g.ball_x <= (g.paddle_x + g.paddle_width)) and (g.ball_y > g.paddle_y)) then
    sfx(0)
    do end (g)["score"] = (g.score + 10)
    do end (g)["ball_y_direction"] = ( - g.ball_y_direction)
    return nil
  else
    return nil
  end
end
local function lose_dead_ball()
  if (g.ball_y > 128) then
    g["lives"] = (g.lives - 1)
    if (g.lives > 0) then
      sfx(1)
      do end (g)["ball_y"] = 24
      return nil
    else
      g["ball_x_direction"] = 0
      g["ball_y_direction"] = 0
      g["ball_x"] = 63
      g["ball_y"] = 63
      g["game_over"] = true
      return nil
    end
  else
    return nil
  end
end
local function _update()
  move_paddle()
  bounce_ball()
  bounce_paddle()
  move_ball()
  return lose_dead_ball()
end
local function _draw()
  cls()
  for i = 1, g.lives do
    spr(1, (90 + (i * 8)), 4)
  end
  print(g.score, 12, 6, 9)
  rectfill(g.paddle_x, g.paddle_y, (g.paddle_x + g.paddle_width), (g.paddle_y + g.paddle_height), 9)
  circfill(g.ball_x, g.ball_y, g.ball_size, 8)
  if g.game_over then
    return print("GAME OVER", 46, 50, 9)
  else
    return nil
  end
end
