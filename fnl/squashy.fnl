;; Macro example
(macro log [message]
  `(printh ,message "games/log" true))

(log "Hello")

;; Game code
(local g {:lives 3
          :score 0
          :paddle_x 52
          :paddle_y 122
          :paddle_width 24
          :paddle_height 4
          :ball_x 64
          :ball_y 64
          :ball_size 3
          :ball_x_direction 5
          :ball_y_direction -3})

(fn move-paddle []
  (if (btn 0) (tset g :paddle_x (- g.paddle_x 3))
      (btn 1) (tset g :paddle_x (+ g.paddle_x 3))))

(fn move-ball []
  (tset g :ball_x (+ g.ball_x g.ball_x_direction))
  (tset g :ball_y (+ g.ball_y g.ball_y_direction)))

(fn bounce-ball []
  (when (or (< g.ball_x g.ball_size) (> g.ball_x (- 128 g.ball_size)))
    (tset g :ball_x_direction (- g.ball_x_direction))
    (sfx 0))
  (when (< g.ball_y g.ball_size)
    (tset g :ball_y_direction (- g.ball_y_direction))
    (sfx 0)))

(fn bounce-paddle []
  (when (and (>= g.ball_x g.paddle_x)
             (<= g.ball_x (+ g.paddle_x g.paddle_width))
             (> g.ball_y g.paddle_y))
    (sfx 0)
    (tset g :score (+ g.score 10))
    (tset g :ball_y_direction (- g.ball_y_direction))))

(fn lose-dead-ball []
  (when (> g.ball_y 128)
    (tset g :lives (- g.lives 1))
    (if (> g.lives 0)
        (do (sfx 1)
            (tset g :ball_y 24))
        (do (tset g :ball_x_direction 0)
            (tset g :ball_y_direction 0)
            (tset g :ball_x 63)
            (tset g :ball_y 63)
            (tset g :game_over true)))))

(fn _update []
  (move-paddle)
  (bounce-ball)
  (bounce-paddle)
  (move-ball)
  (lose-dead-ball))

(fn _draw []
  (cls)
  (for [i 1 g.lives]
    (spr 1 (+ 90 (* i 8)) 4))
  (print g.score 12 6 9)
  (rectfill g.paddle_x g.paddle_y
            (+ g.paddle_x g.paddle_width)
            (+ g.paddle_y g.paddle_height) 9)
  (circfill g.ball_x g.ball_y g.ball_size 8)
  (when g.game_over
    (print "GAME OVER" 46 50 9)))
