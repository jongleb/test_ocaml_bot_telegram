type t

val init: check_timeout:float -> timeout:float -> string list -> t

val run: t -> unit Lwt.t