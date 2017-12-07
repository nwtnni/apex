open Graphics
open Settings
open Ctype
open Sdlevent
open Sdlkey
open Draw

type t = {
  clp_id      : id;
  clg_id      : id;
  mutable sel : int;
  mutable pos : pos;
}

let create clg_id clp_id = {
  clp_id; clg_id; pos = (0, 0); sel = 0
}

let to_pos st game =
  let p = List.find (fun p' -> p'.p_id = st.clp_id) game.players in p.p_pos

let get_direction () =
  if is_key_pressed KEY_w && is_key_pressed KEY_a then Some NW else
  if is_key_pressed KEY_w && is_key_pressed KEY_d then Some NE else
  if is_key_pressed KEY_s && is_key_pressed KEY_d then Some SE else
  if is_key_pressed KEY_s && is_key_pressed KEY_a then Some SW else
  if is_key_pressed KEY_w then Some N else
  if is_key_pressed KEY_d then Some E else
  if is_key_pressed KEY_s then Some S else
  if is_key_pressed KEY_a then Some W else None

let move st d =
  let (x, y) = st.pos in
  let cps  = client_player_speed in
  let cps' = int_of_float (sqrt 2. *. (float_of_int cps) /. 2.) in
  let _ = match d with
  | NW -> st.pos <- (x - cps' , y + cps')
  | NE -> st.pos <- (x + cps' , y + cps')
  | SE -> st.pos <- (x + cps' , y - cps')
  | SW -> st.pos <- (x - cps' , y - cps')
  | N  -> st.pos <- (x , y + cps)
  | E  -> st.pos <- (x + cps , y)
  | S  -> st.pos <- (x , y - cps)
  | W  -> st.pos <- (x - cps , y) in
  clear_graph ()

let rec loop st () =
  Sdltimer.delay client_tick_cooldown;

  let _ = match get_direction () with
  | None   -> ()
  | Some d -> move st d in

  let st' = Router.move_location st.clg_id st.clp_id st.pos (fun s -> s) in
  let p' = List.find (fun p -> p.p_id = st.clp_id) st'.players in
  let _ = st.pos <- p'.p_pos in

  let _ = if is_key_pressed KEY_q then st.sel <- st.sel - 1 else () in
  let _ = if is_key_pressed KEY_e then st.sel <- st.sel + 1 else () in
  if List.length p'.p_inv = 0 then draw_state st' p' ""; loop st () else

  let g_id = List.nth p'.p_inv (st.sel mod (List.length p'.p_inv)) in
  let g = List.find (fun g -> g.g_id = g_id) st'.guns in
  let _ = if is_key_pressed KEY_SPACE then
    Router.fire st.clg_id st.clp_id g_id (fun s -> ())
  else () in draw_state st' p' g.g_type;

  loop st ()

let run st =
  open_graph (" " ^ (string_of_int client_width) ^ "x" ^ (string_of_int client_height));
  set_window_title "Apex";

  Sdl.init [`EVENTTHREAD; `VIDEO; `TIMER];
  Sdlkey.enable_key_repeat ?delay:(Some 0) ?interval:(Some 10) ();
  Sdlvideo.set_video_mode 1 1 [];

  loop st ()
