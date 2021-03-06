(* ---------------------------- *)
(*                              *)
(*        Map Generation        *)
(*                              *)
(* ---------------------------- *)

(* How many entities the game starts with *)
let initial_rocks = 5
let initial_guns  = 5
let initial_ammo  = 5

(* Ammo per pack *)
let ammo_count () = 10 + (Random.int 10)

(* HP per player *)
let player_hp = 100

(* Default gun owner *)
let no_owner = (-1)

(* ---------------------------- *)
(*                              *)
(*       Dimension Scaling      *)
(*                              *)
(* ---------------------------- *)

(* Ring of death initial radius. Starts from map center. *)
let ring_radius = 10000.00

(* Map dimensions. *)
let map_width  = 1000.00
let map_height = 1000.00

(* Vision radius around player. *)
let vision_radius = 5000.00

(* Entity radii. *)
let player_radius = 20.00
let ammo_radius   = 10.00
let gun_radius    = 10.00
let rock_radius   = 10.00

(* ---------------------------- *)
(*                              *)
(*      Server Simulation       *)
(*                              *)
(* ---------------------------- *)

(* Rate at which cooldown timer decreases *)
let gun_cd_rate = 1

(* Timeout value for bullets *)
let bullet_timeout = 1000

(* Rate at which ring of death radius decreases *)
let constrict_rate = 0.0

(* Interval between ammo drops *)
let ammo_spawn_cd = 500

(* Number of ammo packs to drop per interval *)
let ammo_spawn_count = 1

(* Interval between gun drops *)
let gun_spawn_cd = 500

(* Number of guns to drop per interval *)
let gun_spawn_count = 1

(* Maximum squared distance a player can travel before flagged as cheating *)
let max_sq_distance = 10000.00

(* ---------------------------- *)
(*                              *)
(*      Client Simulation       *)
(*                              *)
(* ---------------------------- *)

let client_width = 1920
let client_height = 1000

(* Delay per client-side tick in milliseconds. *)
let client_tick_cooldown = 3

(* Player movement per client-side tick *)
let client_player_speed = 6
