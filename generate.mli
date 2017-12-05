(* This module contains helper functions for generating items.
 *
 * Given a state, these functions create a random drop of
 * the specified type that doesn't collide with anything in the map. *)
type t

val create : unit -> t

val ammo : t -> State.t -> Type.ammo

val bullet : t -> Type.player -> Type.gun -> Type.bullet list

val gun : t -> State.t -> Type.gun

val rock : t -> State.t -> Type.rock

(* Creates a player with the specified ID. *)

val player : t -> State.t -> Type.id -> Type.player
